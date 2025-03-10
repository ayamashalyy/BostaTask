//
//  ImageViewerVC.swift
//  BostaTask
//
//  Created by Aya Mashaly on 10/03/2025.
//

import UIKit

class ImageViewerVC: UIViewController {
    
    @IBOutlet weak var zoomImage: UIImageView!
    
    var imageUrl: String?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupGestures()
        
        if let imageUrl = imageUrl, let url = URL(string: imageUrl) {
            zoomImage.sd_setImage(with: url, placeholderImage: UIImage(named: "test"))
        }
    }
    
    private func setupUI() {
        view.backgroundColor = .black
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareImage))
        zoomImage.isUserInteractionEnabled = true
    }
    
    private func setupGestures() {
        let clickGesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch))
        zoomImage.addGestureRecognizer(clickGesture)
    }
    
    
    @objc private func handlePinch(_ gesture: UIPinchGestureRecognizer) {
        guard let view = gesture.view else { return }
        
        if gesture.state == .changed || gesture.state == .began {
            view.transform = view.transform.scaledBy(x: gesture.scale, y: gesture.scale)
            gesture.scale = 1
        }
    }
    
    @objc private func shareImage() {
        guard let image = zoomImage.image else { return }
        let activityController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        present(activityController, animated: true)
    }
}
