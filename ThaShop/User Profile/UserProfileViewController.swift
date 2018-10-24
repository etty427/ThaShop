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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
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
        profileTableView.contentInset.right = 10
        profileTableView.frame = CGRect(x: 0, y: 20, width: view.frame.width, height: 400)
        profileTableView.register(UITableViewCell.self, forCellReuseIdentifier: "profile")
        
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
        let cell = UITableViewCell()
        cell.textLabel?.text = "Test Code"
        return cell
    }
    
    
}
