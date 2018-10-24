//
//  NewsCell.swift
//  ThaShop
//
//  Created by Ty rainey on 10/11/18.
//  Copyright © 2018 Ty rainey. All rights reserved.
//

import UIKit

final class NewsCell: UITableViewCell {
    
    lazy var title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Times Roman", size: 12)
        label.textColor = .black
        return label
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    let vc = NewsViewController()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(title)
        setUpCellView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setUpCellView() {
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            title.leftAnchor.constraint(equalTo: leftAnchor, constant: 5),
            ])
    }
}
