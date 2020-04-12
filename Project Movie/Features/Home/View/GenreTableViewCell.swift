//
//  GenreTableViewCell.swift
//  Project Movie
//
//  Created by Cahaya Ramadhan on 11/04/20.
//  Copyright © 2020 Cahaya Ramadhan. All rights reserved.
//

import UIKit

class GenreTableViewCell: UITableViewCell {
    
    @IBOutlet weak var labelGenre: UILabel!
    
    var idGenre = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
