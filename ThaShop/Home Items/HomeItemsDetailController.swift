//
//  HomeItemsDetailController.swift
//  ThaShop
//
//  Created by Ty rainey on 9/6/18.
//  Copyright © 2018 Ty rainey. All rights reserved.
//

import UIKit

protocol AddItemsToCart {
    var item: [Cart] { get set }
}

final class HomeItemsDetailController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, AddItemsToCart {
    var item: [Cart] = []
    
    
    lazy var favButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "heartitem"), for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        return button
    }()
    
    lazy var likeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "heart"), for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 10, height: 30)
        return button
    }()
    
    lazy var itemImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        return image
    }()
    
    lazy var itemLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "iPad Pro (128 GB) - Space Grey"
        label.font = UIFont(name: "Times Roman", size: 12)
        label.textAlignment = .center
        return label
    }()
    
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "$499.99"
        label.font = UIFont(name: "Times Roman", size: 12)
        label.textColor = .lightGray
        label.textAlignment = .center
        return label
    }()
    
    lazy var likesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "200 likes"
        label.font = UIFont.boldSystemFont(ofSize: 8)
        label.textColor = .black
        return label
    }()
    lazy var separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        view.frame = CGRect(x: 20, y: 260, width: 330, height: 0.5)
        return view
    }()
    
    lazy private var addToCardButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("ADD TO CART", for: .normal)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(addToCart), for: .touchUpInside)
        button.backgroundColor = .red
        return button
    }()
    
    lazy private var likeCollectionview: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let myCollectionView:UICollectionView = UICollectionView(frame: CGRect(x: 0, y: 460, width: view.frame.width, height: 60), collectionViewLayout: layout)
        myCollectionView.dataSource = self
        myCollectionView.delegate = self
        myCollectionView.backgroundColor = .white
        myCollectionView.contentInset.left = 10
        myCollectionView.contentInset.right = 10
        myCollectionView.showsHorizontalScrollIndicator = false
        myCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "MyCell")
        myCollectionView.translatesAutoresizingMaskIntoConstraints = false
        return myCollectionView
    }()
    
    let vc = HomeViewController()
    let cellId = "details"
    var titlePassed = ""
    var pricePassed = ""
    var commentsPassed = ""
    var likesPassed = ""
    var imagePassed = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Product Details"
        setupDetails()
        priceLabel.text = "$" + pricePassed
        itemLabel.text = titlePassed
        likesLabel.text = likesPassed
        itemImageView.image = UIImage(named: imagePassed)
        view.backgroundColor = .white
    }
    
    @objc func addToCart() {
        print("Added to cart!")
        addToCardButton.setTitle("Added to Cart", for: .normal)
        let cart = Cart(itemImage: imagePassed, itemName: titlePassed, price: pricePassed)
        let vc = CartViewController()
        vc.item.append(cart)
        
    }

    private func setupDetails() {
        itemImageView.image = UIImage(named: "clouds")
        view.addSubview(addToCardButton)
        view.addSubview(likesLabel)
        view.addSubview(favButton)
        view.addSubview(itemLabel)
        view.addSubview(priceLabel)
        view.addSubview(likeButton)
        view.addSubview(separatorView)
        view.addSubview(itemImageView)
        view.addSubview(likeCollectionview)
        
        NSLayoutConstraint.activate([
            favButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            favButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            
            itemLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 270),
            itemLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            
            priceLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 270),
            priceLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 290),
            
            likeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 300),
            likeButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            
            likesLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 307),
            likesLabel.leftAnchor.constraint(equalTo: likeButton.rightAnchor, constant: 7),
            
            itemImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            itemImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            itemImageView.widthAnchor.constraint(equalToConstant: 195),
            itemImageView.heightAnchor.constraint(equalToConstant: 195),
            
            addToCardButton.widthAnchor.constraint(equalToConstant: 334),
            addToCardButton.heightAnchor.constraint(equalToConstant: 40),
            addToCardButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 345),
            addToCardButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ])
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath)
        myCell.backgroundColor = .blue
        myCell.layer.cornerRadius = 25
        return myCell
    }
}
