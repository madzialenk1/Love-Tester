//
//  RegisterViewController.swift
//  LoveTester
//
//  Created by Magdalena  Pękacka on 04/05/2020.
//  Copyright © 2020 Magdalena  Pękacka. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    
    @IBOutlet weak var registerButton: UIButton!
    
    var userNotSignedUp: Bool = true
    var startEditing: Bool = false
    
    var database: DatabaseReference!
    override func viewDidLoad() {
        super.viewDidLoad()
        database = Database.database().reference()
        registerButton.layer.cornerRadius = 20
    }
    
    @IBAction func beginEditingGender(_ sender: UITextField) {
        if startEditing == false {
            startEditing = true
        let alert = UIAlertController(title: "Gender", message: "Type K if woman or M if man", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        }
    }
    @IBAction func editingDidEnd(_ sender: UITextField) {
        guard let text = sender.text, !text.isEmpty else {
            return
        }
        guard let email = emailTextField.text, !email.isEmpty else{
          return
        }
        if let index = email.firstIndex(of: "@") {
            let firstPart = email.prefix(upTo: index)
            database.child("users").child("\(firstPart)").setValue(text)
        }
        
    }
    @IBAction func registerButtonPressed(_ sender: UIButton) {

        showSpinner()
        
        if let email = emailTextField.text, let password = passwordTextField.text {
            
            if !self.validate(password: password) {
                self.createAlert(title: "Error", message: "Your password has to contain 1 capital letter, 1 small letter, 1 number and 8-10 characters")
                self.removeSpinner()
                return
            }
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    self.createAlert(title: "Error", message: e.localizedDescription)
                    self.removeSpinner()
                }
                else {
                    if let index = email.firstIndex(of: "@"){
                        let firstPart = email.prefix(upTo: index)
                        let defaults = UserDefaults.standard
                        defaults.set(firstPart, forKey: "name")
                    }
                    self.userNotSignedUp = false
                    self.removeSpinner()
                    self.performSegue(withIdentifier: "registerToTest", sender: self)
                }
                
            }
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        if userNotSignedUp {
            return false
        }
        return true
    }
    
    
    func createAlert(title: String, message: String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            alert.dismiss(animated: true,completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func validate(password: String) -> Bool {
        
        
        let capitalLetter  = ".*[A-Z]+.*"
        let texttest = NSPredicate(format:"SELF MATCHES %@", capitalLetter)
        guard texttest.evaluate(with: password) else { return false }
        
        let numberRegEx  = ".*[0-9]+.*"
        let texttest1 = NSPredicate(format:"SELF MATCHES %@", numberRegEx)
        guard texttest1.evaluate(with: password) else { return false }
        
        let smallLetter  = ".*[a-z]+.*"
        let texttest2 = NSPredicate(format:"SELF MATCHES %@", smallLetter)
        guard texttest2.evaluate(with: password) else { return false }
        
        let passCounter = password.count
        if passCounter < 8 || passCounter > 10 { return false }
        
        return true
    }
}

