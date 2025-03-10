//
//  ProfileViewController.swift
//  BostaTask
//
//  Created by Aya Mashaly on 09/03/2025.
//

import UIKit
import RxSwift
import RxCocoa

class ProfileViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = ProfileViewModel()
    private let disposeBag = DisposeBag()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTableView()
        bindViewModel()
        viewModel.fetchUsers()
    }
    
    // MARK: - Setup Methods
    
    private func setupTableView() {
        tableView.register(UINib(nibName: "AlbumTableViewCell", bundle: nil), forCellReuseIdentifier: "AlbumTableViewCell")
        setupTableHeader()
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
    
    // MARK: - Bind ViewModel
    
    private func bindViewModel() {
        
        // Bind user data to labels
        viewModel.user
            .compactMap { $0 }
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: {  [weak self] user in
                self?.nameLabel.text = user.name
                self?.addressLabel.text = "\(user.address.street), \(user.address.suite), \(user.address.city), \(user.address.zipcode)"
            })
            .disposed(by: disposeBag)
        
        // Bind albums to tableView
        viewModel.albums
            .observe(on: MainScheduler.instance)
            .bind(to: tableView.rx.items(cellIdentifier: "AlbumTableViewCell", cellType: AlbumTableViewCell.self)) { index, album, cell in
                cell.albumTitleLabel.text = album.title
            }
            .disposed(by: disposeBag)
        
        // Handle item selection
        tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                guard let self = self else { return }
                let albumDetails = AlbumDetailsViewController()
                albumDetails.albumId = self.viewModel.albums.value[indexPath.row].id
                let navController = UINavigationController(rootViewController: albumDetails)
                navController.modalPresentationStyle = .fullScreen
                self.present(navController, animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
    }
}
