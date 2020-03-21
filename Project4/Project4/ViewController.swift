//
//  ViewController.swift
//  Project4
//
//  Created by Mark Patrick Perdon on 3/20/20.
//  Copyright © 2020 Mark Patrick Perdon. All rights reserved.
//

import UIKit
class ViewController: UIViewController{
    @IBOutlet var instructionLabel: UILabel!
    @IBOutlet var urlField: UITextField!
    
    override func viewDidLoad() {
        instructionLabel.text = "Please enter any URL"
        
        super.viewDidLoad()
    }
    
    @IBAction func submitURLButton(_ sender: Any) {

        guard let urlStr = urlField?.text, !urlStr.isEmpty else {
            let ac = UIAlertController(title: "Text Field is Blank", message: "Please enter a url", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
            present(ac, animated: true)
            return
        }
        
        if let vc = storyboard?.instantiateViewController(identifier: "Browser") as?
        BroswerViewController{
            
            //add url validation
            print("vs")
            vc.urlString = urlStr
            navigationController?.pushViewController(vc, animated: true)
            
        }
    }
    
    //implement some form of url validation
    /*
    func isValidUrl(urlGiven: String) -> Bool {
        let regex = "((http|https|ftp)://)?((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: urlGiveb)
    }
     */
}


