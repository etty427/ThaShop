//
//  Item.swift
//  ThaShop
//
//  Created by Ty rainey on 9/27/18.
//  Copyright © 2018 Ty rainey. All rights reserved.
//

import Foundation

struct Item {
    let image : String
    let title: String
    let price: Int
    let comments: Int
    let likes: Int
    
    init(image:String,title:String,price:Int,comments:Int, likes:Int) {
        
        self.image = image
        self.title = title
        self.price = price
        self.comments = comments
        self.likes = likes
    }
}
