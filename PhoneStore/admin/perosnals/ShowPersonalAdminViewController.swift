//
//  ShowPersonalAdminViewController.swift
//  PhoneStore
//
//  Created by Blessme on 30.04.2021.
//

import UIKit
import Firebase


class ShowPersonalAdminViewController: UIViewController {
    @IBOutlet weak var addPersonButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        downLoadingData()
        
    }
    
    init(email: String, name: String, position: String){
        self.email = email
        self.name = name
        self.position = position
        
        var personals:[Personal] = []
    }
    
    
    
    //Функция получения данных из Firebase
    func downLoadingData(){
        
        let ref = Database.database().reference().child("personal")
        
        ref.observeSingleEvent(of: .value, with: {snapshot in
            
            for child in snapshot.children{
                let snap = child as! DataSnapshot
                let value = snap.value as! [String: Any]
                
                let mail = value["mail"] as! String
                
                let name = value["name"] as! String
                
                let position = value["position"] as! String
                
                print(name)
                print(mail)
                print(position)
                
                var u: Personal(email: mail, name: name, position: position)
                personals.append(u)
                
            }
            
            
            
        })
        
        
        
    }
    
    func addListItem(){
       
    }
    
    @IBAction func addPersonAction(_ sender: UIButton) {
        
    }
    
}
