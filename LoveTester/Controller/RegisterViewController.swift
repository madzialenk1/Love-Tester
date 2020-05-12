//
//  RegisterViewController.swift
//  LoveTester
//
//  Created by Magdalena  Pękacka on 04/05/2020.
//  Copyright © 2020 Magdalena  Pękacka. All rights reserved.
//

import UIKit
import Firebase
class RegisterViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    @IBAction func registerButtonPressed(_ sender: UIButton) {
         if let email = emailTextField.text, let password = passwordTextField.text {
              Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    print(e.localizedDescription)
                } else {
                    self.performSegue(withIdentifier: "registerToTest", sender: self)
                }
                
              }
    }
    
    }
}
