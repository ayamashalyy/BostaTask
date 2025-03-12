//
//   UIView.swift
//  BostaTask
//
//  Created by Aya Mashaly on 11/03/2025.
//

import Foundation
import UIKit

extension UIView {
    
    func enableAutoLayout() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func matchParentView(parentView: UIView, horizontalMargin: CGFloat = 0, verticalMargin: CGFloat = 0){
        parentView.addSubview(self)
        topAnchor.constraint(equalTo: parentView.topAnchor, constant: verticalMargin)
            .isActive = true
        bottomAnchor.constraint(equalTo: parentView.bottomAnchor, constant: -verticalMargin)
            .isActive = true
        leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: horizontalMargin)
            .isActive = true
        trailingAnchor.constraint(equalTo: parentView.trailingAnchor, constant: -horizontalMargin)
            .isActive = true
        
    }
    
    func anchorWidth(equalToConstant: CGFloat)  {
        widthAnchor.constraint(equalToConstant: equalToConstant)
            .isActive = true
    }
    func anchorHeight(equalToConstant: CGFloat)  {
        heightAnchor.constraint(equalToConstant: equalToConstant)
            .isActive = true
    }
    
    func anchorXAxis(leading:NSLayoutXAxisAnchor? = nil, trailing:NSLayoutXAxisAnchor? = nil, leadingConstant: CGFloat = 0, trailingConstant: CGFloat = 0) {
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: leadingConstant)
                .isActive = true
        }
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: trailingConstant)
                .isActive = true
        }
    }
    
    func anchorYAxis(top:NSLayoutYAxisAnchor? = nil, bottom:NSLayoutYAxisAnchor? = nil, topConstant: CGFloat = 50, bottomConstant: CGFloat = 0) {
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: topConstant)
                .isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: bottomConstant)
                .isActive = true
        }
    }
    
}
