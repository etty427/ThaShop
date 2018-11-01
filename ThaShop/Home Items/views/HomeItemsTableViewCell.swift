//
//  HomeItemsTableViewCell.swift
//  ThaShop
//
//  Created by Ty rainey on 9/5/18.
//  Copyright © 2018 Ty rainey. All rights reserved.
//

import UIKit

final class HomeItemsTableViewCell: UITableViewCell {
    
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
        label.frame = CGRect(x: 0, y: 0, width: 100, height: 15)
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
        view.frame = CGRect(x: 20, y: 210, width: 330, height: 0.5)
        return view
    }()
    
    let vc = HomeViewController()
  
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: vc.cellId)
        
        addSubview(likesLabel)
        addSubview(favButton)
        addSubview(itemLabel)
        addSubview(priceLabel)
        addSubview(likeButton)
        addSubview(separatorView)
        addSubview(itemImageView)
        
        setupCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets.init(top: 5, left: 5, bottom: 5, right: 5))
    }
    
    func setupCell() {
        NSLayoutConstraint.activate([
            favButton.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            favButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            
            itemLabel.topAnchor.constraint(equalTo: topAnchor, constant: 220),
            itemLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            
            priceLabel.topAnchor.constraint(equalTo: topAnchor, constant: 220),
            priceLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 260),
            priceLabel.widthAnchor.constraint(equalToConstant: 100),
            
            likeButton.topAnchor.constraint(equalTo: topAnchor, constant: 240),
            likeButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            
            likesLabel.topAnchor.constraint(equalTo: topAnchor, constant: 247),
            likesLabel.leftAnchor.constraint(equalTo: likeButton.rightAnchor, constant: 7),
            
            itemImageView.topAnchor.constraint(equalTo: topAnchor, constant: 50),
            itemImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            itemImageView.widthAnchor.constraint(equalToConstant: 125),
            itemImageView.heightAnchor.constraint(equalToConstant: 125)
            ])
    }

}
