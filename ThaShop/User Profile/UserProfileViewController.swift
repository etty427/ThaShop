//
//  UserProfileViewController.swift
//  ThaShop
//
//  Created by Ty rainey on 9/24/18.
//  Copyright © 2018 Ty rainey. All rights reserved.
//

import UIKit

final class UserProfileViewController: UIViewController {
    
    var profileTableView: UITableView = {
        var table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    var logoutButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("LOGOUT", for: .normal)
        button.setTitleColor(UIColor(named: "white"), for: .normal)
        button.frame = CGRect(x: 15, y: 500, width: 346, height: 40)
        button.layer.cornerRadius = 10
        button.backgroundColor = .red
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(logoutButton)
        //view.backgroundColor = .lightGray
        configureTableView()
        setupNav()
        setupView()
    }
    
    private func setupNav() {
        let editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: nil)
        editButton.tintColor = .white
        self.navigationItem.leftBarButtonItem  = editButton
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = .white
    }
    
    private func configureTableView() {
        profileTableView.separatorStyle = .none
        profileTableView.delegate = self
        profileTableView.dataSource = self
        profileTableView.isScrollEnabled = false
        profileTableView.bounces = false
        profileTableView.allowsSelection = false
        profileTableView.center = view.center
        profileTableView.frame = CGRect(x: 10, y: 20, width: 370, height: 470)
        profileTableView.register(UINib(nibName: "UserProfileTableViewCell", bundle: nil), forCellReuseIdentifier: "profile")
        
        view.addSubview(profileTableView)
    }
    
    func setupView() {
        NSLayoutConstraint.activate([
        
            ])
    }
}

extension UserProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = profileTableView.dequeueReusableCell(withIdentifier: "profile", for: indexPath) as! UserProfileTableViewCell
        
        return cell
    }
    
    
}
