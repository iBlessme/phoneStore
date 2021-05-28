//
//  SettingStorageViewController.swift
//  PhoneStore
//
//  Created by Blessme on 19.04.2021.
//

import UIKit
import Firebase

class SettingStorageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func exitBurron(_ sender: UIButton) {
        do{
            try Auth.auth().signOut()
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(identifier: "mainView") as UIViewController
            self.present(vc, animated: true, completion: nil)
        }catch{
            print("Ошибка при выходе")
        }
    }
}
