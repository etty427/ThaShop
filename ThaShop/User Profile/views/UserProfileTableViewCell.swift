//
//  UserProfileTableViewCell.swift
//  ThaShop
//
//  Created by Ty rainey on 9/27/18.
//  Copyright © 2018 Ty rainey. All rights reserved.
//

import UIKit

class UserProfileTableViewCell: UITableViewCell {
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var mottoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        profileImage.layer.cornerRadius = 20
        usernameLabel.text = "Ty Rainman"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
