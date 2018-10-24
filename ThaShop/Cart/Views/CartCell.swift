//
//  CartCell.swift
//  ThaShop
//
//  Created by Ty rainey on 10/24/18.
//  Copyright © 2018 Ty rainey. All rights reserved.
//

import UIKit

class CartCell: UICollectionViewCell {
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemSizeAndColor: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
