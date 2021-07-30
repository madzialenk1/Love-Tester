//
//  ViewController.swift
//  LoveTester
//
//  Created by Magdalena  Pękacka on 02/05/2020.
//  Copyright © 2020 Magdalena  Pękacka. All rights reserved.
//

import UIKit
import CLTypingLabel

class ViewController: UIViewController {
    
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loveLabel: CLTypingLabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerButton.layer.cornerRadius = 0.3 * registerButton.bounds.size.height
        loginButton.layer.cornerRadius = 0.3 * loginButton.bounds.size.height
        loveLabel.text = "Love Tester"
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = true
//        navigationItem.backBarButtonItem = UIBarButtonItem(
//            title: "Hello", style: .plain, target: nil, action: nil)
//        navigationItem.backBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Abril Fatface", size: 20)!], for: .normal)
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
         navigationController?.isNavigationBarHidden = false
        
    }
    @IBAction func unwindToStart(_ unwindSegue: UIStoryboardSegue) {

      }
    
    
    
    
}

