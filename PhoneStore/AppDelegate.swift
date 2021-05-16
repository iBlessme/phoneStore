//
//  AppDelegate.swift
//  PhoneStore
//
//  Created by Blessme on 15.04.2021.
//

import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        checkUser()
        return true
    }
    func checkUser(){
        Auth.auth().addStateDidChangeListener{(auth, user) in
            if user != nil{
                let user = Auth.auth().currentUser
                let ref = Database.database().reference().child("personal").child(String(user!.uid))
                ref.queryOrderedByKey().observeSingleEvent(of: .value, with: {(snapshot) in
                    
                    let user = snapshot.value as? NSDictionary
                    
                    let position = user?["position"] as? String
                    
                    if position == nil{
                        self.showNewWindow(newvc: "mainView")
                    }
                    else if position == "storage"{
                        self.showNewWindow(newvc: "mainStorage")
                    }
                    else if position == "admin"{
                        self.showNewWindow(newvc: "mainAdmin")
                    }
                })
            }
        
        }
    }
        func showNewWindow(newvc: String){
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(identifier: newvc) as UIViewController
            self.window?.rootViewController?.present(vc, animated: true, completion: nil)
        }
        
      

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
    
    
}

