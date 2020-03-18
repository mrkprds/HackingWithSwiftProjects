//
//  DetailViewController.swift
//  Project1
//
//  Created by Mark Patrick Perdon on 3/18/20.
//  Copyright © 2020 Mark Patrick Perdon. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    var selectedImage: String?
    var imageCountOf: Int?
    var imageTotal: Int?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let imageCountOf = imageCountOf, let imageTotal = imageTotal  {
            title = "Picture \(imageCountOf + 1) out of \(imageTotal)"
        }
        
        navigationItem.largeTitleDisplayMode = .never
        if let imageToLoad = selectedImage{
            imageView.image = UIImage(named: imageToLoad)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.hidesBarsOnTap = false
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
