//
//  AlbumDetailsViewController+SearchBar.swift
//  BostaTask
//
//  Created by Aya Mashaly on 10/03/2025.
//

import Foundation
import UIKit

extension AlbumDetailsViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filterPhotos(by: searchText)
    }
}
