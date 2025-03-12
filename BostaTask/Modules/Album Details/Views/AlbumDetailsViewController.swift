//
//  AlbumDetailsViewController.swift
//  BostaTask
//
//  Created by Aya Mashaly on 10/03/2025.
//

import UIKit
import RxSwift
import SDWebImage

class AlbumDetailsViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var viewModel = AlbumViewModel()
    private let disposeBag = DisposeBag()
    var albumId: Int?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupBackButton()
        setupCollectionView()
        setupSearchBar()
        bindViewModel()
        
        if let albumId = albumId {
            viewModel.fetchPhotos(for: albumId)
        }
    }
    
    // MARK: - Setup Methods
    private func setupNavigationBar() {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 30, weight: .bold)
        ]
        navigationController?.navigationBar.titleTextAttributes = attributes
        self.title = "Album Details"
    }
    
    private func setupBackButton() {
        let backButton = UIBarButtonItem(image: UIImage(named: "back"),
                                         style: .plain,
                                         target: self,
                                         action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = backButton
    }
    
    @objc private func backButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    
    private func setupCollectionView() {
        collectionView.register(UINib(nibName: "PhotoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PhotoCollectionViewCell")
        
        // Set the delegate for UICollectionViewDelegateFlowLayout
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    
    private func setupSearchBar() {
        searchBar.placeholder = "Search in images.."
        searchBar.delegate = self
    }
    
    // MARK: - Bind ViewModel
    private func bindViewModel() {
        viewModel.filteredPhotos
            .observe(on: MainScheduler.instance)
            .bind(to: collectionView.rx.items(cellIdentifier: "PhotoCollectionViewCell", cellType: PhotoCollectionViewCell.self)) { index, photo, cell in
                cell.imageView.sd_setImage(with: URL(string: photo.thumbnailUrl), placeholderImage: UIImage(named: "test"))
                cell.imageTapped = {
                    let fullScreenVC = FullScreenImageVC()
                    fullScreenVC.image = cell.imageView.image
                    fullScreenVC.modalPresentationStyle = .fullScreen
                    self.present(fullScreenVC, animated: true, completion: nil)
                }
            }
            .disposed(by: disposeBag)
    }
}
