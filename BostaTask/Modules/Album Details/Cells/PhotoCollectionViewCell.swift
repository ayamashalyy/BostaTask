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
    
    var loadedImage: UIImage? {
            return imageView.image
        }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.isUserInteractionEnabled = true
        setupGesture()
    }
    
    private func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        imageView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func handleTap() {
        print("Cell tapped")
        imageTapped?()
    }
}
