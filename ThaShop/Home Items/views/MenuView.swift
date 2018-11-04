//
//  MenuView.swift
//  ThaShop
//
//  Created by Ty rainey on 11/2/18.
//  Copyright © 2018 Ty rainey. All rights reserved.
//

import UIKit

class MenuView: UIView {
    lazy private var registerButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Register", for: .normal)
        button.layer.cornerRadius = 5
        //button.addTarget(self, action: #selector(addToCart), for: .touchUpInside)
        button.backgroundColor = .red
        return button
    }()
    
    lazy private var loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Login", for: .normal)
        button.layer.cornerRadius = 5
        //button.addTarget(self, action: #selector(addToCart), for: .touchUpInside)
        button.backgroundColor = .red
        return button
    }()
    
    lazy private var settingsButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Settings", for: .normal)
        button.layer.cornerRadius = 5
        //button.addTarget(self, action: #selector(addToCart), for: .touchUpInside)
        button.backgroundColor = .red
        return button
    }()
}
