//
//   UIView.swift
//  BostaTask
//
//  Created by Aya Mashaly on 11/03/2025.
//

import Foundation
import UIKit

extension UIView {
    // Matches the view's edges to its parent view
    func matchParentView(parentView: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.leadingAnchor.constraint(equalTo: parentView.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: parentView.trailingAnchor),
            self.topAnchor.constraint(equalTo: parentView.topAnchor),
            self.bottomAnchor.constraint(equalTo: parentView.bottomAnchor)
        ])
    }
    
    // Sets a fixed width constraint
    func anchorWidth(equalToConstant width: CGFloat) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    // Sets a fixed height constraint
    func anchorHeight(equalToConstant height: CGFloat) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    // Anchors the view's leading edge to another view's leading edge with an optional constant
    func anchorXAxis(leading: NSLayoutXAxisAnchor, leadingConstant: CGFloat = 0) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.leadingAnchor.constraint(equalTo: leading, constant: leadingConstant).isActive = true
    }
    
    // Anchors the view's top edge to another view's top edge with an optional constant
    func anchorYAxis(top: NSLayoutYAxisAnchor, topConstant: CGFloat = 0) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: top, constant: topConstant).isActive = true
    }
}
