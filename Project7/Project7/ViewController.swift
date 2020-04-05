//
//  ViewController.swift
//  Project7
//
//  Created by Mark Patrick Perdon on 4/3/20.
//  Copyright © 2020 Mark Patrick Perdon. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var petitions = [Petition]()
    var urlString = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let search = UIBarButtonItem(
                barButtonSystemItem: .search,
                target: self,
                action: #selector(showSearchFilter))
        
        let reload = UIBarButtonItem(
                barButtonSystemItem: .refresh,
                target: self,
                action: #selector(loadParsedData))
        navigationItem.leftBarButtonItems = [search, reload]

        navigationItem.rightBarButtonItem =
            UIBarButtonItem(title: "Credit",
                            style: .done,
                            target: self,
                            action: #selector(showCredits))
        
        if navigationController?.tabBarItem.tag == 0{
            urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
        }else{
            urlString = "https://api.whitehouse.gov/v1/petitions.json?signatureCountFloor=1000&limit=100"
        }
        
        loadParsedData()
    }
    
    @objc func showCredits(){
        let ac = UIAlertController(title: "Date being pulled from:",
                                   message: urlString,
                                   preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Close", style: .default))
        present(ac, animated: true)
    }
    
    @objc func showSearchFilter(){
        let ac = UIAlertController(title: "Search Filter",
                                   message: "Enter any keyword pertaining to a title or content of body",
                                   preferredStyle: .alert)
        ac.addTextField{
            (textField) in
            textField.placeholder = "Enter Keyword title"
        }
        
        let submitAction = UIAlertAction(title: "Submit", style: .cancel) {
            [weak self, weak ac] _ in
            guard let searchQuery = ac?.textFields?[0].text, !searchQuery.isEmpty else { return }
            self?.filter(keyword: searchQuery)
        }
        
        ac.addAction(submitAction)
        ac.addAction(UIAlertAction(title: "Cancel", style: .default))
        present(ac, animated: true)
    }
    
    func filter(keyword: String?){
        loadParsedData()
        if let keyword = keyword, !keyword.isEmpty{
            let allPetitions = petitions
            petitions = allPetitions.filter({
                return $0.title.contains(keyword) || $0.body.contains(keyword)
            })
            tableView.reloadData()
            print(petitions)
        }else{
            let ac = UIAlertController(title: "Text field is empty",
                                       message: "Please enter a keyword",
                                       preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Close", style: .default))
            ac.present(ac, animated: true)
        }
    }
    
    func showErr() {
        let ac = UIAlertController(
            title: "Loading Error",
            message: "There was a problem loading the feed, please check your conenction.",
            preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Close", style: .default))
        present(ac, animated: true)
    }
    
    func parse(json: Data){
        let deconder = JSONDecoder()
        if let jsonPetitions = try? deconder.decode(Petitions.self, from:  json){
            petitions = jsonPetitions.results
            tableView.reloadData()
        }
    }
    
    @objc func loadParsedData(){
        if let url = URL(string: urlString){
            if let data = try? Data(contentsOf: url){
                parse(json: data)
                return
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition = petitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell 
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}

