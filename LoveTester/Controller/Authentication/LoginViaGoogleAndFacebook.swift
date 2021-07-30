//
//  LoginViaGoogleAndFacebook.swift
//  LoveTester
//
//  Created by Magdalena  Pękacka on 08/07/2020.
//  Copyright © 2020 Magdalena  Pękacka. All rights reserved.
//

import Foundation
import FBSDKLoginKit
import GoogleSignIn

class LoginViaGoogleAndFacebook: UIViewController, GIDSignInDelegate{
    
    
    //MARK:Google SignIn Delegate
    func sign(inWillDispatch signIn: GIDSignIn!, error: Error!) {
        // myActivityIndicator.stopAnimating()
    }
    // Present a view that prompts the user to sign in with Google
    func sign(_ signIn: GIDSignIn!,
              present viewController: UIViewController!) {
        self.present(viewController, animated: true, completion: nil)
    }

    // Dismiss the "Sign in with Google" view
    func sign(_ signIn: GIDSignIn!,
              dismiss viewController: UIViewController!) {
        self.dismiss(animated: true, completion: nil)
    }

    //completed sign In
    public func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {

        if (error == nil) {
            let familyName = user.profile.familyName!
            print(familyName)
            performTest()
            signInfo(name: familyName)
        } else {
            print("\(error.localizedDescription)")
        }
    
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let g = GIDSignInButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
//        g.center = view.center
//        view.addSubview(g)
        
        if let token = AccessToken.current,
            !token.isExpired {
        }
        

    }
    
    @IBAction func facebookButtonPressed(_ sender: UIButton) {
        
        let loginManager = LoginManager()
        
        if let _ = AccessToken.current {
            loginManager.logOut()
        } else {
            loginManager.logIn(permissions: [], from: self) { [weak self] (result, error) in
                if let e = error {
                    print(e.localizedDescription)
                } else {
                    guard let result = result, !result.isCancelled else {
                        print("User cancelled login")
                        return
                    }
                    
                    self!.performTest()
                }
            }
        }
    }
    
    
    func performTest(){
        
        let menuViewController = self.storyboard?.instantiateViewController(withIdentifier: "Info") as! MenuViewController
        menuViewController.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(menuViewController, animated: true)
    }

    func signInfo(name: String){
        let defaults = UserDefaults.standard
        defaults.set("couple", forKey: "gender")
        defaults.set(name, forKey: "name")
    }
    
    func getInfo() {
        var name: String = ""
        let graphRequest:GraphRequest = GraphRequest(graphPath: "me", parameters: ["fields":"first_name,last_name"])
        graphRequest.start(completionHandler: { (connection, result, error) -> Void in
            if ((error) != nil) {
                print("Error: \(String(describing: error))")
            }
            else {
                if
                    let fields = result as? [String:Any],
                    let firstName = fields["first_name"] as? String,
                    let lastName = fields["last_name"] as? String
                   
                {
                    print("firstName -> \(firstName)")
                    print("lastName -> \(lastName)")
                    name = "\(firstName)\(lastName)"
                    self.signInfo(name: name)
                    
                }
               
            }
        })
    }
   
    
    @IBAction func googleLoginButtonPressed(_ sender: UIButton) {
        
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().delegate=self

        GIDSignIn.sharedInstance().signIn()
        

    }
    
    
    
}
