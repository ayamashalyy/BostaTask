//
//  ProfileViewController+TableView.swift
//  BostaTask
//
//  Created by Aya Mashaly on 10/03/2025.
//

import Foundation
import UIKit

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumTableViewCell", for: indexPath) as? AlbumTableViewCell else {
            return UITableViewCell()
        }
        cell.albumTitleLabel.text = albums[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let albumDetails = AlbumDetailsViewController()
        albumDetails.modalPresentationStyle = .fullScreen
        present(albumDetails, animated: true, completion: nil)
    }
    
    func setupTableHeader() {
        
        let headerLabel = UILabel()
        
        headerLabel.text = "My Albums"
        headerLabel.font = UIFont.boldSystemFont(ofSize: 18)
        headerLabel.textAlignment = .left
        
        headerLabel.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 45)
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 45))
        
        headerView.addSubview(headerLabel)
        
        tableView.tableHeaderView = headerView
    }
}
