//
//  BroswerViewController.swift
//  Project4
//
//  Created by Mark Patrick Perdon on 3/21/20.
//  Copyright © 2020 Mark Patrick Perdon. All rights reserved.
//

import UIKit
import WebKit

class BroswerViewController: UIViewController, WKNavigationDelegate {
    var urlString: String!
    var webView: WKWebView!

    
    override func loadView() {
        super.viewDidLoad()
        
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: urlString)!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
