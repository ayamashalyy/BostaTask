//
//  ImageViewerVC.swift
//  BostaTask
//
//  Created by Aya Mashaly on 10/03/2025.
//

import UIKit

class ImageViewerVC: UIViewController {
    
    var image: UIImage?
    
    let imageView: ImageScrollView = {
        let v = ImageScrollView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        guard let image = self.image else{
            dismiss(animated: false, completion: nil)
            return
        }
        imageView.display(image: image)
        
    }
    
    private func setupUI() {
        view.addSubview(imageView)
        imageView.matchParentView(parentView: view)
        imageView.setup()
        view.backgroundColor = .white
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .action,
            target: self,
            action: #selector(shareImage)
        )
    }
    
    @objc private func shareImage() {
        guard let image = self.image else { return }
        let activityVC = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        present(activityVC, animated: true, completion: nil)
    }
}
