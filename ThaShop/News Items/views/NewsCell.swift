//
//  NewsCell.swift
//  ThaShop
//
//  Created by Ty rainey on 10/11/18.
//  Copyright © 2018 Ty rainey. All rights reserved.
//

import UIKit

final class NewsCell: UITableViewCell {
    
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsTitleLabel: UILabel!
    lazy var title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Times Roman", size: 12)
        label.textColor = .black
        return label
    }()
    
    let articleImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        articleImage.backgroundColor = .blue
    }
    
    let vc = NewsViewController()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //addSubview(title)
        //addSubview(articleImage)
        //setUpCellView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setUpCellView() {
        NSLayoutConstraint.activate([
            articleImage.leftAnchor.constraint(equalTo: leftAnchor, constant: 30),
            articleImage.widthAnchor.constraint(equalToConstant: 50),
            articleImage.heightAnchor.constraint(equalToConstant: 50),
            articleImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            title.leftAnchor.constraint(equalTo: articleImage.rightAnchor, constant: 20),
            title.centerYAnchor.constraint(equalTo: centerYAnchor),
            title.widthAnchor.constraint(equalTo: widthAnchor, constant: 200),
            title.heightAnchor.constraint(equalToConstant: 60),

            ])
    }
}
