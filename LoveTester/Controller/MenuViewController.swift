//
//  MenuViewController.swift
//  LoveTester
//
//  Created by Magdalena  Pękacka on 05/05/2020.
//  Copyright © 2020 Magdalena  Pękacka. All rights reserved.
//

import Foundation
import UIKit
class MenuViewController: UIViewController {
    
    @IBOutlet weak var testView: UIView!
    @IBOutlet weak var statisticsView: UIView!
    @IBOutlet weak var adviceView: UIView!
    @IBOutlet weak var logoutView: UIView!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        testView.layer.cornerRadius = testView.frame.size.height * 0.40
        statisticsView.layer.cornerRadius = statisticsView.frame.size.height * 0.40
        adviceView.layer.cornerRadius = adviceView.frame.size.height * 0.40
        logoutView.layer.cornerRadius = logoutView.frame.size.height * 0.40
        navigationController?.isNavigationBarHidden = true
    }
    
    
    
    
    
 
    

    
    @IBAction func checkAdvicePressed(_ sender: UIButton) {
        performSegue(withIdentifier: "checkAdvice", sender: self)
        
    }
    @IBAction func logoutPressed(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
        
    }
    
    
    
    
}
