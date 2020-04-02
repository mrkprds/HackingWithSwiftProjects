//
//  ViewController.swift
//  Project7
//
//  Created by Mark Patrick Perdon on 4/3/20.
//  Copyright © 2020 Mark Patrick Perdon. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var petitions = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "Some Title"
        cell.detailTextLabel?.text = "This is a description"
        return cell 
    }


}

