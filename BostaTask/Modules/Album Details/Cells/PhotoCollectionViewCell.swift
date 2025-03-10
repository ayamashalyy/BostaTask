//
//  PhotoCollectionViewCell.swift
//  BostaTask
//
//  Created by Aya Mashaly on 10/03/2025.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    var imageTapped: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupGesture()
    }
    
    private func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func handleTap() {
        imageTapped?()
    }
}
