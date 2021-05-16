//
//  ShopTableViewController.swift
//  PhoneStore
//
//  Created by Blessme on 16.05.2021.
//

import UIKit
import Firebase

class ShopTableViewController: UITableViewController {
    var data: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let ref = Database.database().reference().child("phones")
        ref.observeSingleEvent(of: .value, with: {(snapshot) in
            
            self.data = []
            
            for child in snapshot.children{
                let snap = child as! DataSnapshot
                let value = snap.value as! [String: Any]
                
                let serialNumber = value["serialNumber"] as! String
                let model = value["model"] as! String
                let memory = value["memory"] as! String
                let color = value["color"] as! String
                let cost = value["cost"] as! String
                
                let phone =
                    """
Модель: \(model)
Память: \(memory)
Цвет: \(color)
Стоимость: \(cost)
Серийный номер: \(serialNumber)
"""
                
                self.data.insert(phone, at: 0)
            }
            
            self.tableView.reloadData()
        })
        
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return data.count
    }

  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellID", for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        cell.textLabel?.numberOfLines = 0;
        print(data[indexPath.row])
        return cell
    }
}
