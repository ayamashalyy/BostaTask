//
//  ProfileViewController.swift
//  BostaTask
//
//  Created by Aya Mashaly on 09/03/2025.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    let albums = [
        "quidem molestiae enim",
        "sunt qui excepturi placeat culpa",
        "omnis laborum odio",
        "non esse culpa molestiae omnis sed optio",
        "eaque aut omnis a",
        "natus impedit quibusdam illo est",
        "quibusdam autem aliquid et et quia",
        "qui fuga est a eum",
        "saepe unde necessitatibus rem",
        "distinctio laborum qui"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTableView()
        
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "AlbumTableViewCell", bundle: nil), forCellReuseIdentifier: "AlbumTableViewCell")
        setupTableHeader()
    }
}
