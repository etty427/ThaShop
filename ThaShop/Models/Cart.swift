//
//  Cart.swift
//  ThaShop
//
//  Created by Ty rainey on 11/1/18.
//  Copyright © 2018 Ty rainey. All rights reserved.
//

import UIKit

class Cart: NSObject {
    var itemImage: String
    var itemName: String
    var priceLabel: String
    
    init(itemImage:String, itemName:String, price:String) {
        self.itemName = itemName
        self.itemImage = itemImage
        self.priceLabel = price
    }
}
