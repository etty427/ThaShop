//
//  FirstViewController.swift
//  ThaShop
//
//  Created by Ty rainey on 9/4/18.
//  Copyright © 2018 Ty rainey. All rights reserved.
//

import UIKit

final class FirstViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    lazy private var navButtonView: UIView = {
        let view = UIView()
        return view
    }()
    lazy private var allButton: UIButton = {
        let button = UIButton()
        return button
    }()
    lazy private var trendingButton: UIButton = {
        let button = UIButton()
        return button
    }()
    lazy private var newItemsButton: UIButton = {
        let button = UIButton()
        return button
    }()
    lazy private var itemTableView: UITableView = {
        let table = UITableView()
        return table
    }()
    lazy private var homeItemsDetailController: UIViewController = {
        let vc = HomeItemsDetailController()
        vc.view.backgroundColor = .white
        addChildViewController(vc)
        vc.didMove(toParentViewController: self)
        return vc
    }()
    
    let cellId = "cell"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedStringKey.font: UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.heavy)]
        let searchButton = UIBarButtonItem(image: UIImage(named: "searchbutton"), style: .plain, target: self, action: nil)
        searchButton.tintColor = .white
        self.navigationItem.rightBarButtonItem = searchButton
        
        let menuButton = UIBarButtonItem(image: UIImage(named: "menubutton"), style: .plain, target: self, action: nil)
        menuButton.tintColor = .white
        self.navigationItem.leftBarButtonItem  = menuButton
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = .white

        setupNavButtonViews()
        homeItemsDetailController.willMove(toParentViewController: nil)
        homeItemsDetailController.view.removeFromSuperview()
        homeItemsDetailController.removeFromParentViewController()
    }
    
    private func setupNavButtonViews() {
        navButtonView.translatesAutoresizingMaskIntoConstraints = false
        navButtonView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        navButtonView.backgroundColor = .black
        
        allButton.translatesAutoresizingMaskIntoConstraints = false
        allButton.backgroundColor = .red
        allButton.setTitle("ALL", for: .normal)
        allButton.layer.cornerRadius = 15
        
        newItemsButton.translatesAutoresizingMaskIntoConstraints = false
        newItemsButton.frame = CGRect(x: 0, y: 0, width: 0, height: 30)
        newItemsButton.backgroundColor = .clear
        newItemsButton.layer.borderColor = UIColor.white.cgColor
        newItemsButton.layer.borderWidth = 1
        newItemsButton.setTitle("NEW", for: .normal)
        newItemsButton.layer.cornerRadius = 15
        
        trendingButton.translatesAutoresizingMaskIntoConstraints = false
        trendingButton.frame = CGRect(x: 0, y: 0, width: 0, height: 30)
        trendingButton.backgroundColor = .clear
        trendingButton.layer.borderColor = UIColor.white.cgColor
        trendingButton.layer.borderWidth = 1
        trendingButton.setTitle("TRENDING", for: .normal)
        trendingButton.layer.cornerRadius = 15
        
        view.addSubview(navButtonView)
        view.addSubview(allButton)
        view.addSubview(newItemsButton)
        view.addSubview(trendingButton)
        view.addSubview(homeItemsDetailController.view)
        
        NSLayoutConstraint.activate([
            allButton.topAnchor.constraint(equalTo: view.topAnchor),
            allButton.widthAnchor.constraint(equalToConstant: 105),
            
            newItemsButton.leftAnchor.constraint(equalTo: allButton.rightAnchor, constant: 10),
            newItemsButton.widthAnchor.constraint(equalToConstant: 105),
            newItemsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            trendingButton.leftAnchor.constraint(equalTo: newItemsButton.rightAnchor, constant: 10),
            trendingButton.widthAnchor.constraint(equalToConstant: 105),
            ])
        configureTableView()
    }
    
    private func configureTableView() {
        itemTableView.translatesAutoresizingMaskIntoConstraints = false
        itemTableView.register(HomeItemsTableViewCell.self, forCellReuseIdentifier: cellId)
        itemTableView.separatorStyle = .none
        itemTableView.delegate = self
        itemTableView.dataSource = self
        itemTableView.frame = CGRect(x: 0, y: 50, width: view.frame.width, height:view.frame.height)
        itemTableView.contentInset.bottom = 120
        
        view.addSubview(itemTableView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! HomeItemsTableViewCell
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = UIColor.lightGray.cgColor
        cell.contentView.layer.cornerRadius = 15
        cell.contentView.layer.masksToBounds = true
        cell.itemImageView.image = UIImage(named: "clouds")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 275
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        navigationController?.pushViewController(homeItemsDetailController, animated: true)
    }
}


