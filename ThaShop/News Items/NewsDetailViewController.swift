//
//  NewsDetailViewController.swift
//  ThaShop
//
//  Created by Ty rainey on 10/11/18.
//  Copyright © 2018 Ty rainey. All rights reserved.
//

import UIKit

final class NewsDetailViewController: UIViewController {

    var newsTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var desc: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var author: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var photo: UIImageView = {
        let label = UIImageView()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var titlePassed = ""
    var authorPassed = ""
    var descriptionPassed = ""
    var imagePassed = ""
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("New details")

        newsTitle.text = titlePassed
        desc.text = descriptionPassed
        author.text = authorPassed
        photo.image = UIImage(named: imagePassed)
        setupView()
        print(titlePassed)
    }
    
    private func setupView() {
        //newsTitle.text = "This Title"
        newsTitle.font = .boldSystemFont(ofSize: 30)
        newsTitle.textAlignment = .center
        
        photo.backgroundColor = .blue
        
        view.addSubview(newsTitle)
        view.addSubview(desc)
        view.addSubview(photo)
        view.addSubview(author)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            newsTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            
            photo.topAnchor.constraint(equalTo: newsTitle.bottomAnchor, constant: 20),
            photo.widthAnchor.constraint(equalToConstant: 100),
            photo.heightAnchor.constraint(equalToConstant: 100),
            
            desc.topAnchor.constraint(equalTo: photo.bottomAnchor, constant: 20),
            ])
    }
}
