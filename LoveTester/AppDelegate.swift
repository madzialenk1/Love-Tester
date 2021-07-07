//
//  AppDelegate.swift
//  LoveTester
//
//  Created by Magdalena  Pękacka on 02/05/2020.
//  Copyright © 2020 Magdalena  Pękacka. All rights reserved.
//

import UIKit
import Firebase
import RealmSwift
import FBSDKCoreKit
import GoogleSignIn

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
          if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
            print("The user has not signed in before or they have since signed out.")
          } else {
            print("\(error.localizedDescription)")
          }
          return
        }
        
        
        
    }
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
              withError error: Error!) {
        print("")
          }


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        GIDSignIn.sharedInstance().clientID = "139301717610-7g6suegl9d2td6k7e9laic2a3tovu5ga.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().delegate = self
        
//        let defaults = UserDefaults.standard
//        defaults.set(0, forKey: "count")
        
        print(Realm.Configuration.defaultConfiguration.fileURL)
        let config = Realm.Configuration(

            schemaVersion: 1,

            migrationBlock: { migration, oldSchemaVersion in

                if (oldSchemaVersion < 1) {

                }
            })

        Realm.Configuration.defaultConfiguration = config
        
        
//        do {
//        let realm = try!  Realm()
//            try? realm.write {
//                realm.deleteAll()
//            }
//        } catch {
//            print(error.localizedDescription)
//        }
//        
        ApplicationDelegate.shared.application(
                   application,
                   didFinishLaunchingWithOptions: launchOptions
               )
        
        
        
        
        return true
    }
   
  

    func application(_ application: UIApplication,
                     open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
      return GIDSignIn.sharedInstance().handle(url)
    }
  

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    func application(
        _ app: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey : Any] = [:]
    ) -> Bool {

        ApplicationDelegate.shared.application(
            app,
            open: url,
            sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
            annotation: options[UIApplication.OpenURLOptionsKey.annotation]
        )
        return GIDSignIn.sharedInstance().handle(url)

    }



}

