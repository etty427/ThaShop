//
//  HomeViewController.swift
//  ThaShop
//
//  Created by Ty rainey on 9/4/18.
//  Copyright © 2018 Ty rainey. All rights reserved.
//

import UIKit

protocol SlideMenuDelegate {
    func slideMenuSelectedAtIndex(_ index: Int32)
}

protocol AddItemsToDict: class {
    var item: [String:String] { get set }
}

final class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, AddItemsToDict {
    var item: [String : String] = [:]
    
    
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
    var menuView: MenuView = {
        let view = MenuView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let cellId = "cell"
    var itemList:[Item] = []
    var delegate: SlideMenuDelegate?
    let images = ["ipad","fitbit","beats","s9","watch"]
    var sorted:[String] = []

    override func viewWillAppear(_ animated: Bool) {
        itemTableView.rowHeight = UITableView.automaticDimension
        itemTableView.estimatedRowHeight = 100
    }
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
    
    func sortList() { // should probably be called sort and not filter
        itemList.sort() { $0.image > $1.image }
        itemTableView.reloadData()
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
        
        configureTableView()
        
        NSLayoutConstraint.activate([
            allButton.topAnchor.constraint(equalTo: view.topAnchor),
            allButton.widthAnchor.constraint(equalToConstant: 105),
            
            newItemsButton.leftAnchor.constraint(equalTo: allButton.rightAnchor, constant: 10),
            newItemsButton.widthAnchor.constraint(equalToConstant: 105),
            newItemsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            trendingButton.leftAnchor.constraint(equalTo: newItemsButton.rightAnchor, constant: 10),
            trendingButton.widthAnchor.constraint(equalToConstant: 105),
            
            itemTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            itemTableView.widthAnchor.constraint(equalToConstant: view.frame.width),
            itemTableView.heightAnchor.constraint(equalToConstant: view.frame.height),
            ])
        view.addSubview(menuView)
    }
    
    private func configureTableView() {
        itemTableView.translatesAutoresizingMaskIntoConstraints = false
        itemTableView.register(HomeItemsTableViewCell.self, forCellReuseIdentifier: cellId)
        itemTableView.separatorStyle = .none
        itemTableView.delegate = self
        itemTableView.dataSource = self
        itemTableView.contentInset.bottom = 120
        itemTableView.showsVerticalScrollIndicator = false
        view.addSubview(itemTableView)
    }
    
    @objc func slideOutMenu() {
        UIView.animate(withDuration: 0.4, animations: {
            self.menuView.isHidden = !self.menuView.isHidden
        }, completion: nil)
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
        itemTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! HomeItemsTableViewCell
        
        let item = itemList[indexPath.row]
        cell.priceLabel.text = "$" + "\(item.price)"
        cell.itemLabel.text = item.title
        cell.likesLabel.text = "\(item.likes)"
        cell.itemImageView.image = UIImage(named: images[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 275
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        itemTableView.deselectRow(at: indexPath, animated: true)
            let vc = HomeItemsDetailController()
            let maindata = itemList[indexPath.row]
            let image = images[indexPath.row]
            vc.titlePassed = maindata.title
            vc.likesPassed = "\(maindata.likes)"
            vc.commentsPassed = "\(maindata.comments)"
            vc.pricePassed = "\(maindata.price)"
            vc.imagePassed = image
            let tabbar = tabBarController as! ShopTabBarVC
            tabbar.item["title"] = maindata.title
            tabbar.item["price"] = "\(maindata.price)"
            tabbar.item["image"] = image
            print("SAved",tabbar.item)
            navigationController?.pushViewController(vc, animated: true)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = segue.destination as? AddItemsToDict
            else { fatalError("wrong vc type") }
        vc.item = item
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
final class MenuView: UIView {
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
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 16.0
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .lightGray
        layer.borderWidth = 3
        let red = UIColor(red: 100.0/255.0, green: 130.0/255.0, blue: 230.0/255.0, alpha: 1.0)
        layer.borderColor = red.cgColor
        //CGRect(x: 0, y: 50, width: 300, height: frame.height)
        
        stackView.addArrangedSubview(stackView)
        stackView.addArrangedSubview(registerButton)
        stackView.addArrangedSubview(loginButton)
        stackView.addArrangedSubview(settingsButton)
        
        NSLayoutConstraint.activate([
           // stackView.topAnchor.constraint(equalTo: topAnchor, constant: 50),
        
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
