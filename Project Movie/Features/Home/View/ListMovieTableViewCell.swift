//
//  ListMovieTableViewCell.swift
//  Project Movie
//
//  Created by Cahaya Ramadhan on 12/04/20.
//  Copyright © 2020 Cahaya Ramadhan. All rights reserved.
//

import UIKit

class ListMovieTableViewCell: UITableViewCell { 
    
    @IBOutlet weak var nameMovie: UILabel!
    @IBOutlet weak var imageMovie: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
