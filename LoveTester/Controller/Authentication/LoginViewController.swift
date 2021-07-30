//
//  LoginViewController.swift
//  LoveTester
//
//  Created by Magdalena  Pękacka on 04/05/2020.
//  Copyright © 2020 Magdalena  Pękacka. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
class LoginViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    var userNotLoggedIn: Bool = true
    var ref : DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        loginButton.layer.cornerRadius = 20
      //  navigationController?.navigationBar
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        showSpinner()
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password) {  authResult, error in
                
                if let e = error {
                    self.removeSpinner()
                    self.createAlert(title: "Error", message: e.localizedDescription)
                    return
                    
                } else {
                    self.userNotLoggedIn = false
                    if let index = email.firstIndex(of: "@"){
                        let firstPart = email.prefix(upTo: index)
                        
                        let defaults = UserDefaults.standard
                        defaults.set(firstPart, forKey: "name")
                        self.ref.child("users").observeSingleEvent(of: .value, with: { (snapshot) in
                            if  let value = snapshot.value as? NSDictionary{
                                if let gender = value["\(firstPart)"]  {
                                    defaults.set(gender, forKey: "gender")
                                }
                            }
                        })
                    }
                    
                    self.removeSpinner()
                    self.performSegue(withIdentifier: "loginToTest", sender: self)
                    
                }
                
            }
            
        }
    }
    
    func createAlert(title: String, message: String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            alert.dismiss(animated: true,completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        if userNotLoggedIn {
            return false
        }
        return true
    }
    
}
