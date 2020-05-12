//
//  LoginViewController.swift
//  LoveTester
//
//  Created by Magdalena  Pękacka on 04/05/2020.
//  Copyright © 2020 Magdalena  Pękacka. All rights reserved.
//

import UIKit
import Firebase
class LoginViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    print(e.localizedDescription)
                } else {
                    self.performSegue(withIdentifier: "loginToTest", sender: self)
                }
                
            }
        }
    }
    
}
