//
//  ViewController.swift
//  Project4
//
//  Created by Mark Patrick Perdon on 3/20/20.
//  Copyright © 2020 Mark Patrick Perdon. All rights reserved.
//

import UIKit
import WebKit


class ViewController: UITableViewController, WKNavigationDelegate{
    var websites = ["apple.com", "facebook.com", "twitter.com"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Select a website"
        navigationController?.navigationBar.prefersLargeTitles = true

        
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return websites.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Websites", for: indexPath)
        cell.textLabel?.text = websites[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(identifier: "ViewWebsite") as? BrowserViewController{
            for website in websites{
                vc.websites.append(website)
            }
            vc.selectedWebsite = websites[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}


