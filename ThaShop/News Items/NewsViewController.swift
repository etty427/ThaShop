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
        newsTableView.rowHeight = UITableView.automaticDimension
        newsTableView.showsHorizontalScrollIndicator = false
        newsTableView.showsVerticalScrollIndicator = false
        newsTableView.contentInset.bottom = 90
        newsTableView.frame = CGRect(x: 0, y: 20, width: view.frame.width, height: view.frame.height)
        
        view.addSubview(newsTableView)
    }

}

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! NewsCell
        cell.title.text = articles[indexPath.row].headline ?? "Title Unknown"
        cell.articleImage.downloaded(from: articles[indexPath.row].urlImage ?? "clouds")
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        newsTableView.deselectRow(at: indexPath, animated: true)
        let news = articles[indexPath.row]
        if let url = URL(string: news.url) {
            UIApplication.shared.openURL(url)
        }
        // Add webview to keep user in app!!
    }
}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}

