//
//  ViewController.swift
//  Project2
//
//  Created by Mark Patrick Perdon on 3/19/20.
//  Copyright © 2020 Mark Patrick Perdon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    
    var numberOfQuestionsAsked = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countries += ["estonia","france","germany","ireland","italy","monaco","nigeria","poland","russia","spain","uk","us"]
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        askQuestion()
        
        //nav item
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .pause , target: self, action: #selector(showScore))
    }
    
    func askQuestion(action: UIAlertAction! = nil){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        title = "Country: \(countries[correctAnswer].uppercased()) | Score: \(score) "
        
        numberOfQuestionsAsked += 1
    }
    
    func resetGame(action: UIAlertAction! = nil){
        score = 0
        numberOfQuestionsAsked = 0
        askQuestion()
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        
        if sender.tag == correctAnswer{
            title = "Correct"
            score += 1
        }else{
            title = "Wrong, you pressed: \(countries[sender.tag].uppercased())"
            if score > 0{
                
                score -= 1
            }else{
                score = 0
            }
        }
        
        if numberOfQuestionsAsked != 10{
            let ac = UIAlertController(title: title, message: "Your score is \(score)", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "continue", style: .default, handler: askQuestion))
            present(ac, animated: true)
        }else{
            let ac = UIAlertController(title: title, message: "You've answered 10 questions already. \n Your final score is \(score)", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Start Over", style: .default, handler: resetGame))
            present(ac, animated: true)
        }
        
    }
    
    @objc func showScore(){
        let ac = UIAlertController(title: "Paused", message: "Your score is \(score)", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "continue", style: .default, handler: nil))
        present(ac, animated: true)
    }
    
}

