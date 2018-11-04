//
//  ShopTabBarVC.swift
//  ThaShop
//
//  Created by Ty rainey on 9/4/18.
//  Copyright © 2018 Ty rainey. All rights reserved.
//

import UIKit

final class ShopTabBarVC: UITabBarController, AddItemsToDict {
    var item: [String : String] = [:]
    var cart: [Dictionary<String, String>] = []
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = segue.destination as? AddItemsToDict
            else { fatalError("wrong vc type") }
        vc.item = item
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tabBar.barTintColor = .black
        tabBar.tintColor = .white
    }
}
