//
//  NewsViewController.swift
//  ThaShop
//
//  Created by Ty rainey on 9/4/18.
//  Copyright © 2018 Ty rainey. All rights reserved.
//

import UIKit

final class NewsViewController: UIViewController {
    
    var articles: [Article] = []
    let cellId = "newsCell"

    lazy var newsTableView: UITableView = {
        let table = UITableView()
        return table
    }()
    
    lazy private var newsDetailViewController: UIViewController = {
        let vc = NewsDetailViewController()
        vc.view.backgroundColor = .white
        addChild(vc)
        vc.didMove(toParent: self)
        return vc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        self.navigationItem.title = "Tech News"
        newsTableView.register(NewsCell.self, forCellReuseIdentifier: cellId)
        fetchNews()
    }
    
    private func fetchNews() {
        var request = URLRequest(url: URL(string: "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=722c05c77ee94c99bb4d8d5e18dedddc")!)
        request.httpMethod = "GET"
        //request.httpBody = try? JSONSerialization.data(withJSONObject: request, options: [])
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if error != nil {
                print(error.debugDescription)
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String : AnyObject]
                if let articlesFromJson = json["articles"] as? [[String : AnyObject]] {
                    for articlesFromJson in articlesFromJson {
                        let article = Article()
                        if let title = articlesFromJson["title"] as? String, let desc = articlesFromJson["description"] as? String, let author = articlesFromJson["author"] as? String, let url = articlesFromJson["url"] as? String, let urlImage = articlesFromJson["urlToImage"] as? String  {
                            
                            article.author = author
                            article.desc = desc
                            article.headline = title
                            article.url = url
                            article.urlImage = urlImage
                        }
                        self.articles.append(article)
                    }
                }
                DispatchQueue.main.async {
                    self.newsTableView.reloadData()
                }
                
            } catch let error {
                print(error)
            }
        }
        task.resume()
    }
    
    private func configureTableView() {
        newsTableView.separatorStyle = .none
        newsTableView.translatesAutoresizingMaskIntoConstraints = false
        newsTableView.delegate = self
        newsTableView.dataSource = self
        newsTableView.contentInset.right = 10
        newsTableView.showsHorizontalScrollIndicator = false
        newsTableView.showsVerticalScrollIndicator = false
        newsTableView.bounces = false
        newsTableView.frame = CGRect(x: 0, y: 20, width: view.frame.width, height: 520)
        
        view.addSubview(newsTableView)
    }

}

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! NewsCell
        cell.title.lineBreakMode = .byTruncatingTail
        cell.title.numberOfLines = 3
        cell.title.text = articles[indexPath.row].headline
        //cell.imageView?.downloadImage(from: articles[indexPath.row].urlImage!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(newsDetailViewController, animated: true)
    }
}

extension UIImageView {
    func downloadImage(from url:String) {
        let urlRequest = URLRequest(url: URL(string:url)!)
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if error != nil {
                print(error.debugDescription)
                return
            }
            DispatchQueue.main.async {
                self.image = UIImage(data: data!)
            }
        }
        task.resume()
    }
}

