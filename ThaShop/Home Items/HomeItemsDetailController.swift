//
//  HomeItemsDetailController.swift
//  ThaShop
//
//  Created by Ty rainey on 9/6/18.
//  Copyright © 2018 Ty rainey. All rights reserved.
//

import UIKit



final class HomeItemsDetailController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
   
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
        button.frame = CGRect(x: 0, y: 20, width: 40, height: 40)
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
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.textColor = .black
        return label
    }()
    lazy var separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        return view
    }()
    
    lazy var imageLikesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        //label.font = UIFont.boldSystemFont(ofSize: 15)
        label.font = UIFont(name: "Times Roman", size: 15)
        label.textColor = .black
        return label
    }()
    lazy var separatorView2: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
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
        myCollectionView.register(UINib(nibName: "HomeDetailCellCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MyCell")
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
    let picImages = ["guy1","guy2","guy3","girl1","girl2","girl3"]

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
        addToCardButton.setTitle("Added to Cart", for: .normal)
        let tabbar = tabBarController as! ShopTabBarVC
        tabbar.cart.append(tabbar.item)
        tabbar.addBadgeToCart()
        print("Cart",tabbar.cart)
        popUpCartMenu()
    }
    
    private func popUpCartMenu() {
        let alert = UIAlertController(title: "", message: "\(titlePassed)  $\(pricePassed)", preferredStyle: .actionSheet)
        let action = UIAlertAction(title: "Go to Cart", style: .default) { (action) in
            
        }
        let imgTitle = UIImage(named:"cart")
        let imgViewTitle = UIImageView(frame: CGRect(x: 60, y: 20, width: 30, height: 30))
        imgViewTitle.image = imgTitle
        
        //alert.view.addSubview(imgViewTitle)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            alert.dismiss(animated: false, completion: nil)
        }
    }

    private func setupDetails() {
        imageLikesLabel.text = "\(picImages.count) users liked this item."
        view.addSubview(addToCardButton)
        view.addSubview(likesLabel)
        view.addSubview(favButton)
        view.addSubview(itemLabel)
        view.addSubview(priceLabel)
        view.addSubview(likeButton)
        view.addSubview(separatorView)
        view.addSubview(itemImageView)
        view.addSubview(likeCollectionview)
        view.addSubview(imageLikesLabel)
        view.addSubview(separatorView2)
        
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
            
            addToCardButton.widthAnchor.constraint(equalToConstant: view.frame.width - 40),
            addToCardButton.heightAnchor.constraint(equalToConstant: 40),
            addToCardButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 345),
            addToCardButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            imageLikesLabel.topAnchor.constraint(equalTo: addToCardButton.bottomAnchor, constant: 30),
            imageLikesLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            separatorView.topAnchor.constraint(equalTo: view.topAnchor, constant: 260),
            separatorView.widthAnchor.constraint(equalToConstant: view.frame.width - 40),
            separatorView.heightAnchor.constraint(equalToConstant: 0.5),
            separatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
       
            separatorView2.topAnchor.constraint(equalTo: view.topAnchor, constant: 440),
            separatorView2.widthAnchor.constraint(equalToConstant: view.frame.width - 40),
            separatorView2.heightAnchor.constraint(equalToConstant: 0.5),
            separatorView2.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ])
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return picImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! HomeDetailCellCollectionViewCell
        let pic = picImages[indexPath.row]
        myCell.userLikeImages.image = UIImage(named: pic)
        return myCell
    }
}
