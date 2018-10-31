//
//  FirstViewController.swift
//  ThaShop
//
//  Created by Ty rainey on 9/4/18.
//  Copyright © 2018 Ty rainey. All rights reserved.
//

import UIKit

protocol SlideMenuDelegate {
    func slideMenuSelectedAtIndex(_ index: Int32)
}

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
        addChild(vc)
        vc.didMove(toParent: self)
        return vc
    }()
    lazy private var menuView: UIView = {
        let view = UIView()
        return view
    }()
    
    let cellId = "cell"
    var itemList:[Item] = []
    var delegate: SlideMenuDelegate?
    let images = ["ipad","fitbit","beats","s9","watch"]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.heavy)]
        let searchButton = UIBarButtonItem(image: UIImage(named: "searchbutton"), style: .plain, target: self, action: nil)
        searchButton.tintColor = .white
        self.navigationItem.rightBarButtonItem = searchButton
        
        let menuButton = UIBarButtonItem(image: UIImage(named: "menubutton"), style: .plain, target: self, action: #selector(slideOutMenu))
        menuButton.tintColor = .white
        self.navigationItem.leftBarButtonItem  = menuButton
        navigationItem.backBarButtonItem?.tintColor = .white
        menuView.isHidden = true
        
        setupNavButtonViews()
        loadJson()
        homeItemsDetailController.willMove(toParent: nil)
        homeItemsDetailController.view.removeFromSuperview()
        homeItemsDetailController.removeFromParent()
    }
    
    private func setupNavButtonViews() {
        navButtonView.translatesAutoresizingMaskIntoConstraints = false
        navButtonView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        navButtonView.backgroundColor = .black
        
        menuView.translatesAutoresizingMaskIntoConstraints = false
        menuView.backgroundColor = .lightGray
        menuView.layer.borderWidth = 3
        let red = UIColor(red: 100.0/255.0, green: 130.0/255.0, blue: 230.0/255.0, alpha: 1.0)
        menuView.layer.borderColor = red.cgColor
        menuView.frame = CGRect(x: 0, y: 50, width: 300, height: view.frame.height)
        
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
        view.addSubview(menuView)
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
    
    @objc func slideOutMenu() {
        //menuView.isHidden = !menuView.isHidden
       menuView.slideInFromLeft()
    }
    
    private func loadJson() {
        
        let url = Bundle.main.url(forResource: "items", withExtension: "json")
        let data = NSData(contentsOf: url!)
        do {
            let object = try JSONSerialization.jsonObject(with: data! as Data, options: .allowFragments)
            if let dictionary = object as? [String:AnyObject]{
                    for inv in dictionary.values {
                        let items = inv as? Array<Any>
                        for stuff in items! {
                            if let inventory = stuff as? [String:AnyObject] {
                                let title = inventory["title"] as! String
                                let price = inventory["price"] as! NSNumber
                                let comments = inventory["comments"] as! Int
                                let likes = inventory["likes"] as! Int
                                let list = Item(image: "", title: title, price: Int(truncating: price), comments: comments, likes: likes)
                                itemList.append(list)
                            }
                        }
                    }
            }
        } catch {
            // Handle Error
            print("Error")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! HomeItemsTableViewCell
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = UIColor.lightGray.cgColor
        cell.contentView.layer.cornerRadius = 15
        cell.contentView.layer.masksToBounds = true
        cell.itemImageView.image = UIImage(named: images[indexPath.row])
        
        let item = itemList[indexPath.row]
        cell.priceLabel.text = String("$\(item.price)")
        cell.itemLabel.text = item.title
        cell.likesLabel.text = "\(item.likes)"
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
extension UIView {
    // Name this function in a way that makes sense to you...
    // slideFromLeft, slideRight, slideLeftToRight, etc. are great alternative names
    func slideInFromLeft(duration: TimeInterval = 1.0, completionDelegate: AnyObject? = nil) {
        // Create a CATransition animation
        let slideInFromLeftTransition = CATransition()
        
        // Set its callback delegate to the completionDelegate that was provided (if any)
        if let delegate: AnyObject = completionDelegate {
            slideInFromLeftTransition.delegate = delegate as? CAAnimationDelegate
        }
        
        // Customize the animation's properties
        slideInFromLeftTransition.type = CATransitionType.push
        slideInFromLeftTransition.subtype = CATransitionSubtype.fromLeft
        slideInFromLeftTransition.duration = duration
        slideInFromLeftTransition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        slideInFromLeftTransition.fillMode = CAMediaTimingFillMode.removed
        
        // Add the animation to the View's layer
        self.layer.add(slideInFromLeftTransition, forKey: "slideInFromLeftTransition")
    }
}
