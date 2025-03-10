//
//  AlbumDetailsViewController.swift
//  BostaTask
//
//  Created by Aya Mashaly on 10/03/2025.
//

import UIKit

class AlbumDetailsViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupSearchBar()
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "PhotoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PhotoCollectionViewCell")
    }
    
    private func setupSearchBar() {
        searchBar.placeholder = "Search in images.."
        searchBar.delegate = self
    }
}
