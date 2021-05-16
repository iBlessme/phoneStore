//
//  SetingsViewController.swift
//  PhoneStore
//
//  Created by Blessme on 17.04.2021.
//

import UIKit

class SetingsViewController: UIViewController {

    @IBOutlet weak var therdButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    @IBOutlet weak var firstButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.firstButton.layer.cornerRadius = 5
        self.secondButton.layer.cornerRadius = 5
        self.therdButton.layer.cornerRadius = 5
       
    }
}
