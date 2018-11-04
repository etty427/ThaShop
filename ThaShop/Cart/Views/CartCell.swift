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
    @IBAction func deleteItem(_ sender: Any) {
        let alert = UIAlertController(title: "Delete Item", message: "Are you sure you want to delete this item from cart?", preferredStyle: .alert)
        let actionDelete = UIAlertAction(title: "Yes, I'm sure.", style: .default) { (actionDelete) in
            print("Deleted")
            let cartItems = ShopTabBarVC()
            for item in cartItems.cart {
                print(item.keys)
            }
            //cartItems.cart.remove(at: item)
        }
        let actionCancel = UIAlertAction(title: "Cancel", style: .destructive, handler:nil)
        
        alert.addAction(actionCancel)
        alert.addAction(actionDelete)
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
        
        let cartCollection = CartViewController()
        DispatchQueue.main.async {
            cartCollection.cartCollectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
