//
//  WebViewController.swift
//  ThaShop
//
//  Created by Ty rainey on 11/8/18.
//  Copyright © 2018 Ty rainey. All rights reserved.
//

import UIKit
import WebKit

final class WebViewController: UIViewController {

    var url:String?
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.load(URLRequest(url: URL(string: url!)!))
    }
}
