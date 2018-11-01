//
//  CartViewController.swift
//  ThaShop
//
//  Created by Ty rainey on 10/24/18.
//  Copyright © 2018 Ty rainey. All rights reserved.
//

import UIKit

final class CartViewController: UIViewController, AddItemsToCart {
    var item: [Cart] = []
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
        label.text = "$500.00"
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
        label.text = "$500.00"
        return label
    }()
    
    override func viewDidAppear(_ animated: Bool) {
        if item.isEmpty {
            let alert = UIAlertController(title: "Cart Items", message: "Your cart is empty", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .destructive, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
        cartCollectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(item.count)
        cartCollectionView.delegate = self
        cartCollectionView.dataSource = self
        
        view.addSubview(cartCollectionView)
        view.addSubview(subtotalLabel)
        view.addSubview(taxLabel)
        view.addSubview(totalLabel)
        view.addSubview(subtotalPrice)
        view.addSubview(taxLabelPrice)
        view.addSubview(totalLabelPrice)
        
        print("List: ",item)
        setupLabels()
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
            ])
    }
}

extension CartViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return item.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cartCollectionView.dequeueReusableCell(withReuseIdentifier: "cart", for: indexPath) as! CartCell
        let cart = item[indexPath.row]
        let vc = HomeItemsDetailController()
        cell.itemName.text = cart.itemName 
        cell.priceLabel.text = cart.priceLabel
        cell.quantityLabel.text = "1"
        cell.itemImage.image = UIImage(named: vc.imagePassed)
        
        return cell
    }
    
    
}
