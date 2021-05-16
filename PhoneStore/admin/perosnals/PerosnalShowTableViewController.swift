//
//  PerosnalShowTableViewController.swift
//  PhoneStore
//
//  Created by Blessme on 15.05.2021.
//

import UIKit
import Firebase

class PerosnalShowTableViewController: UITableViewController {
    
    var data = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let ref = Database.database().reference().child("personal")
        ref.observeSingleEvent(of: .value, with: {(snapshot) in
            
            self.data = []
            
            for child in snapshot.children{
                let snap = child as! DataSnapshot
                let value = snap.value as! [String: Any]
                
                let mail = value["mail"] as! String
                let name = value["name"] as! String
                let position = value["position"] as! String
                
                let personal = "Имя: \(name). Логин: \(mail). Должность: \(position)"
                
                self.data.insert(personal, at: 0)
            }
            
            self.tableView.reloadData()
        })

       
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let personal = data[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellID", for: indexPath)
            cell.textLabel?.text = personal
            return cell
        
            
    }
    
}
