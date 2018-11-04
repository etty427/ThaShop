//
//  CartViewController.swift
//  ThaShop
//
//  Created by Ty rainey on 10/24/18.
//  Copyright © 2018 Ty rainey. All rights reserved.
//

import UIKit

final class CartViewController: UIViewController {
    let cellID = "cart"
    
    let cartCollectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 186, height: 259)
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.scrollDirection = .horizontal
        let collection:UICollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 375, height: 300), collectionViewLayout: layout)
        collection.register(UINib(nibName: "CartCell", bundle: nil), forCellWithReuseIdentifier: "cart")
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .white
        return collection
    }()
    
    let subtotalLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Subtotal: "
        return label
    }()
    
    let taxLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Taxes: "
        return label
    }()
    
    let totalLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Total: "
        return label
    }()
    
    let subtotalPrice: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let taxLabelPrice: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "$0.00"
        return label
    }()
    
    let totalLabelPrice: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "$0.00"
        return label
    }()
    
    lazy private var checkoutButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("CHECKOUT", for: .normal)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(checkout), for: .touchUpInside)
        button.backgroundColor = .red
        return button
    }()
    
    @objc func checkout() {
        
    }
    override func viewWillAppear(_ animated: Bool) {
        //tab.cart.removeAll()
        let tab = tabBarController as! ShopTabBarVC
        print(tab.cart.count)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cartCollectionView.delegate = self
        cartCollectionView.dataSource = self
        
        view.addSubview(cartCollectionView)
        view.addSubview(subtotalLabel)
        view.addSubview(taxLabel)
        view.addSubview(totalLabel)
        view.addSubview(subtotalPrice)
        view.addSubview(taxLabelPrice)
        view.addSubview(totalLabelPrice)
        view.addSubview(checkoutButton)
        
        setupLabels()
        cartCollectionView.reloadData()
    }
    
    private func setupLabels() {
        NSLayoutConstraint.activate([
            subtotalLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 350),
            subtotalLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            
            subtotalPrice.topAnchor.constraint(equalTo: view.topAnchor, constant: 350),
            subtotalPrice.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            
            taxLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 400),
            taxLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            
            taxLabelPrice.topAnchor.constraint(equalTo: view.topAnchor, constant: 400),
            taxLabelPrice.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            
            totalLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 450),
            totalLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            
            totalLabelPrice.topAnchor.constraint(equalTo: view.topAnchor, constant: 450),
            totalLabelPrice.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            
            checkoutButton.widthAnchor.constraint(equalToConstant: 334),
            checkoutButton.heightAnchor.constraint(equalToConstant: 40),
            checkoutButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 500),
            checkoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ])
    }
}

extension CartViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let tab = tabBarController as! ShopTabBarVC
        if tab.cart.count == 0 {
            self.cartCollectionView.setEmptyMessage("Your cart is empty.", backgroundColor: UIColor.clear, textColor: UIColor.lightGray)
        } else {
        return tab.cart.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cartCollectionView.dequeueReusableCell(withReuseIdentifier: "cart", for: indexPath) as! CartCell
        let tabbar = tabBarController as! ShopTabBarVC
        let cart = tabbar.cart[indexPath.row]
        cell.itemName.text = cart["title"]
        cell.priceLabel.text = "$\(cart["price"] ?? "Unknown")"
        cell.quantityLabel.text = "1"
        cell.itemImage.image = UIImage(named: cart["image"]!)
        
        self.subtotalPrice.text = cart["price"] ?? "$0.00"
        
        DispatchQueue.main.async {
            self.cartCollectionView.reloadData()
        }
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
    
}

extension UICollectionView {
    
    func setEmptyMessage(_ message: String, backgroundColor: UIColor, textColor: UIColor) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = textColor
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont(name: "TrebuchetMS", size: 18)
        messageLabel.sizeToFit()
        
        self.backgroundView = messageLabel
        self.backgroundView?.backgroundColor = backgroundColor
    }
    
    func restore() {
        self.backgroundView = nil
    }
}
