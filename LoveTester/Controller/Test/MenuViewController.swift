//
//  MenuViewController.swift
//  LoveTester
//
//  Created by Magdalena  Pękacka on 05/05/2020.
//  Copyright © 2020 Magdalena  Pękacka. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class MenuViewController: UIViewController {
    
    @IBOutlet weak var testView: UIView!
    @IBOutlet weak var statisticsView: UIView!
    @IBOutlet weak var adviceView: UIView!
    @IBOutlet weak var logoutView: UIView!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        testView.layer.cornerRadius = testView.frame.size.height * 0.30
        statisticsView.layer.cornerRadius = statisticsView.frame.size.height * 0.30
        adviceView.layer.cornerRadius = adviceView.frame.size.height * 0.30
        logoutView.layer.cornerRadius = logoutView.frame.size.height * 0.30
        
        navigationController?.isNavigationBarHidden = true
    }
  
    
 
    
    @IBAction func logoutPressed(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            performSegue(withIdentifier: "start", sender: self)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
    }
    
    @IBAction func unwind( _ seg: UIStoryboardSegue) {
    }
    
}
