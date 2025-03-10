//
//  AlbumTableViewCell.swift
//  BostaTask
//
//  Created by Aya Mashaly on 10/03/2025.
//

import UIKit

class AlbumTableViewCell: UITableViewCell {
    
    @IBOutlet weak var albumTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
}
