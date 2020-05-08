//
//  ViewController.swift
//  Project7
//
//  Created by Mark Patrick Perdon on 4/3/20.
//  Copyright © 2020 Mark Patrick Perdon. All rights reserved.
//

import UIKit

class ViewController: UITableViewController{
    var petionManager = PetitionManager()
    var petitions = PetitionsModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        petionManager.petitionsDelegate = self
        
        if navigationController?.tabBarItem.tag == 0{
            petionManager.urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
        }else{
            petionManager.urlString = "https://api.whitehouse.gov/v1/petitions.json?signatureCountFloor=1000&limit=100"
        }
        
        petionManager.fetchPetitions()
        
        let search = UIBarButtonItem(barButtonSystemItem: .search,
                                     target: self,
                                     action: #selector(showSearchBox))
        
        let reload = UIBarButtonItem(barButtonSystemItem: .refresh,
                                     target: self,
                                     action: #selector(reloadPetitions))
        
        navigationItem.leftBarButtonItems = [search, reload]
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Credit",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(showSource))
    }
    
    @objc func showSource(){
        let ac = UIAlertController(title: "Date being pulled from:",
                                   message: petionManager.urlString,
                                   preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Close", style: .default))
        present(ac, animated: true)
    }
    
    @objc func showSearchBox(){
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
            self?.searchPetition(keyword: searchQuery)
        }
        
        ac.addAction(submitAction)
        ac.addAction(UIAlertAction(title: "Cancel", style: .default))
        present(ac, animated: true)
    }
    
    func searchPetition(keyword: String?){
        if let keyword = keyword, !keyword.isEmpty{
            let allPetitions = petitions.list
            petitions.list = allPetitions.filter({
                return $0.title.contains(keyword) || $0.body.contains(keyword)
            })
            tableView.reloadData()
            //                print(petionManager.petitions)
        }else{
            let ac = UIAlertController(title: "Text field is empty",
                                       message: "Please enter a keyword",
                                       preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Close", style: .default))
            ac.present(ac, animated: true)
        }
    }
    
    @objc func reloadPetitions(){
        petionManager.fetchPetitions()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition = petitions.list[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = petitions.list[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.list.count
    }
}

extension ViewController: PetitionsDelgate{
    func didFailWithError(_ error: Error) {
        print(error)
    }
    
    func didGetPetitions(_ petitionManager: PetitionManager, _ petitions: PetitionsData?) {
        if let petitions = petitions{
            self.petitions.list = petitions.results
            tableView.reloadData()
        }
    }
}
