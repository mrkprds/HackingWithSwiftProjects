//
//  ViewController.swift
//  Project5
//
//  Created by Mark Patrick Perdon on 3/24/20.
//  Copyright © 2020 Mark Patrick Perdon. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var allWords = [String]()
    var usedWords = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
        barButtonSystemItem: .add,
        target: self,
        action: #selector(promptForAnswer))
        
        if let startWordsURl = Bundle.main.url(forResource: "start", withExtension: "txt"){
            
            if let startWords = try? String(contentsOf: startWordsURl){
                allWords = startWords.components(separatedBy: "\n")
            }
        }
        
        print(allWords.count)
        if allWords.isEmpty{
            allWords = ["silworm"]
        }
        startGame()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        cell.textLabel?.text = usedWords[indexPath.row]
        return cell
    }
    
    func startGame(){
        title = allWords.randomElement()
        usedWords.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    @objc func promptForAnswer(){
        let ac = UIAlertController(
            title: "Enter Answer",
            message: nil,
            preferredStyle: .alert)
        
        ac.addTextField()
        
        let submitAction = UIAlertAction(
            title: "Submit",
            style: .default){
                [weak self, weak ac] _ in
                
                guard let answer = ac?.textFields?[0].text else { return }
                self?.submit(answer)
        }
            ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    func submit(_ answer: String){
        let lowerAnswer = answer.lowercased()
        let errorTitle: String
        let errorMessage: String
        
        
        if !lowerAnswer.isEmpty{
            if isPossible(word: lowerAnswer){
                if isOriginal(word: lowerAnswer){
                    if isReal(word: lowerAnswer){
                        usedWords.insert(lowerAnswer, at: 0)
                        let indexPath = IndexPath(row: 0, section: 0)
                        tableView.insertRows(at: [indexPath], with: .automatic)
                        
                        return
                    }else{
                        errorTitle = "Word not recognized"
                        errorMessage = "Not a valid word"
                    }
                }else{
                    errorTitle = "Word Used"
                    errorMessage = "Think outside the box"
                }
            }else{
                errorTitle = "Impossible"
                errorMessage = "You can't spell that from \(title!.lowercased())"
            }
        }else{
            errorTitle = "Enter something"
            errorMessage = "wot u think dis a joke???"
        }
        let ac = UIAlertController(
                   title: errorTitle,
                   message: errorMessage,
                   preferredStyle: .alert)
               ac.addAction(UIAlertAction(
                   title: "Close",
                   style: .default))
               present(ac, animated: true)
    }
 
    func isPossible(word: String) -> Bool{
        guard var tempWord = title?.lowercased() else {
            return false
        }
        for letter in word{
            if let position = tempWord.firstIndex(of: letter){
                tempWord.remove(at: position)
            }else{
                return false
            }
        }
        
        return true
    }
    
    func isOriginal(word: String) -> Bool{
        return !usedWords.contains(word)
    }
    
    func isReal(word: String) -> Bool{
        let checker = UITextChecker()
        //use utf16 for counting words in apple frameworks
        let range  = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange =  checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound
    }
}

