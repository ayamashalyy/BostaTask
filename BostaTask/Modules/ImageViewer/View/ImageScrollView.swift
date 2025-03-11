//
//  ImageScrollView.swift
//  BostaTask
//
//  Created by Aya Mashaly on 11/03/2025.
//

import Foundation
import UIKit

@objc public protocol ImageScrollViewDelegate: UIScrollViewDelegate {
    func imageScrollViewDidChangeOrientation(imageScrollView: ImageScrollView)
}

open class ImageScrollView: UIScrollView {
    
    @objc public enum ScaleMode: Int {
        case aspectFill
        case aspectFit
        case widthFill
        case heightFill
    }
    
    @objc public enum Offset: Int {
        case begining
        case center
    }
   
    static let kZoomInFactorFromMinWhenDoubleTap: CGFloat = 2
    
    @objc open var imageContentMode: ScaleMode = .widthFill
    @objc open var initialOffset: Offset = .begining
    
    @objc public private(set) var zoomView: UIImageView? = nil
    
    @objc open weak var imageScrollViewDelegate: ImageScrollViewDelegate?

    var imageSize: CGSize = CGSize.zero
    private var pointToCenterAfterResize: CGPoint = CGPoint.zero
    private var scaleToRestoreAfterResize: CGFloat = 1.0
    open var maxScaleFromMinScale: CGFloat = 3.0
    
    override open var frame: CGRect {
        willSet {
            if frame.equalTo(newValue) == false && newValue.equalTo(CGRect.zero) == false && imageSize.equalTo(CGSize.zero) == false {
                prepareToResize()
            }
        }
        
        didSet {
            if frame.equalTo(oldValue) == false && frame.equalTo(CGRect.zero) == false && imageSize.equalTo(CGSize.zero) == false {
                recoverFromResizing()
            }
        }
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func initialize() {
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        bouncesZoom = true
        decelerationRate = UIScrollView.DecelerationRate.fast
        delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(ImageScrollView.changeOrientationNotification), name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    @objc public func adjustFrameToCenter() {
        guard let unwrappedZoomView = zoomView else { return }
        
        var frameToCenter = unwrappedZoomView.frame
        
        // Center horizontally
        if frameToCenter.size.width < bounds.width {
            frameToCenter.origin.x = (bounds.width - frameToCenter.size.width) / 2
        } else {
            frameToCenter.origin.x = 0
        }
        
        // Center vertically
        if frameToCenter.size.height < bounds.height {
            frameToCenter.origin.y = (bounds.height - frameToCenter.size.height) / 2
        } else {
            frameToCenter.origin.y = 0
        }
        
        unwrappedZoomView.frame = frameToCenter
    }
    
    private func prepareToResize() {
        let boundsCenter = CGPoint(x: bounds.midX, y: bounds.midY)
        pointToCenterAfterResize = convert(boundsCenter, to: zoomView)
        scaleToRestoreAfterResize = zoomScale
        
        if scaleToRestoreAfterResize <= minimumZoomScale + CGFloat(Float.ulpOfOne) {
            scaleToRestoreAfterResize = 0
        }
    }
    
    private func recoverFromResizing() {
        setMaxMinZoomScalesForCurrentBounds()
        let maxZoomScale = max(minimumZoomScale, scaleToRestoreAfterResize)
        zoomScale = min(maximumZoomScale, maxZoomScale)
        
        let boundsCenter = convert(pointToCenterAfterResize, to: zoomView)
        var offset = CGPoint(x: boundsCenter.x - bounds.size.width / 2.0, y: boundsCenter.y - bounds.size.height / 2.0)
        
        let maxOffset = maximumContentOffset()
        let minOffset = minimumContentOffset()
        
        offset.x = max(minOffset.x, min(maxOffset.x, offset.x))
        offset.y = max(minOffset.y, min(maxOffset.y, offset.y))
        
        contentOffset = offset
    }
    
    private func maximumContentOffset() -> CGPoint {
        return CGPoint(x: contentSize.width - bounds.width, y: contentSize.height - bounds.height)
    }
    
    private func minimumContentOffset() -> CGPoint {
        return CGPoint.zero
    }
    
    // MARK: - Set up
    open func setup() {
        var topSupperView = superview
        while topSupperView?.superview != nil {
            topSupperView = topSupperView?.superview
        }
        topSupperView?.layoutIfNeeded()
        
        DispatchQueue.main.async {
            self.refresh()
        }
    }

    // MARK: - Display image
    @objc open func display(image: UIImage) {
        if let zoomView = zoomView {
            zoomView.removeFromSuperview()
        }
        
        zoomView = UIImageView(image: image)
        zoomView!.isUserInteractionEnabled = true
        addSubview(zoomView!)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ImageScrollView.doubleTapGestureRecognizer(_:)))
        tapGesture.numberOfTapsRequired = 2
        zoomView!.addGestureRecognizer(tapGesture)
        
        configureImageForSize(image.size)
    }
    
    private func configureImageForSize(_ size: CGSize) {
        imageSize = size
        contentSize = imageSize
        setMaxMinZoomScalesForCurrentBounds()
        zoomScale = minimumZoomScale
        
        switch initialOffset {
        case .begining:
            contentOffset = CGPoint.zero
        case .center:
            let xOffset = contentSize.width < bounds.width ? 0 : (contentSize.width - bounds.width) / 2
            let yOffset = contentSize.height < bounds.height ? 0 : (contentSize.height - bounds.height) / 2

            switch imageContentMode {
            case .aspectFit:
                contentOffset = CGPoint.zero
            case .aspectFill:
                contentOffset = CGPoint(x: xOffset, y: yOffset)
            case .heightFill:
                contentOffset = CGPoint(x: xOffset, y: 0)
            case .widthFill:
                contentOffset = CGPoint(x: 0, y: yOffset)
            }
        }
    }
    
    
    private func setMaxMinZoomScalesForCurrentBounds() {
        let xScale = bounds.width / imageSize.width
        let yScale = bounds.height / imageSize.height
        
        var minScale: CGFloat = 1
        switch imageContentMode {
        case .aspectFill:
            minScale = max(xScale, yScale)
        case .aspectFit:
            minScale = min(xScale, yScale)
        case .widthFill:
            minScale = xScale
        case .heightFill:
            minScale = yScale
        }
        
        let maxScale = maxScaleFromMinScale * minScale
        if minScale > maxScale {
            minScale = maxScale
        }
        
        maximumZoomScale = maxScale
        minimumZoomScale = minScale * 0.999
        
        
    }
    
    // MARK: - Gesture
    @objc func doubleTapGestureRecognizer(_ gestureRecognizer: UIGestureRecognizer) {
        if zoomScale >= minimumZoomScale * ImageScrollView.kZoomInFactorFromMinWhenDoubleTap - 0.01 {
            setZoomScale(minimumZoomScale, animated: true)
        } else {
            let center = gestureRecognizer.location(in: gestureRecognizer.view)
            let zoomRect = zoomRectForScale(ImageScrollView.kZoomInFactorFromMinWhenDoubleTap * minimumZoomScale + 50, center: center)
            zoom(to: zoomRect, animated: true)
        }
    }
    
    private func zoomRectForScale(_ scale: CGFloat, center: CGPoint) -> CGRect {
        var zoomRect = CGRect.zero
        zoomRect.size.height = frame.size.height / scale
        zoomRect.size.width = frame.size.width / scale
        zoomRect.origin.x = center.x - (zoomRect.size.width / 2.0)
        zoomRect.origin.y = center.y - (zoomRect.size.height / 2.0)
        return zoomRect
    }
    
    open func refresh() {
        if let image = zoomView?.image {
            display(image: image)
        }
    }
    
    // MARK: - Actions
    @objc func changeOrientationNotification() {
        DispatchQueue.main.async {
            self.configureImageForSize(self.imageSize)
            self.imageScrollViewDelegate?.imageScrollViewDidChangeOrientation(imageScrollView: self)
        }
    }
}
