//
//  ViewController.swift
//  MemoryGame
//
//  Created by Apps2M on 20/10/22.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

    }


    @IBAction func SelectDifficult(_ sender: UIButton) {
        for s in difficulty{
            difficulty[s.key] = false
        }
        
        difficulty[sender.titleLabel?.text?.lowercased() ?? ""] = true
    }
}

