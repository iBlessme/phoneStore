//
//  addNewPhoneViewController.swift
//  PhoneStore
//
//  Created by Blessme on 06.05.2021.
//

import UIKit
import Firebase
import MobileCoreServices


class addNewPhoneViewController: UIViewController{

    @IBOutlet weak var serialNumberPhone: UITextField!
    @IBOutlet weak var modelPhone: UITextField!
    @IBOutlet weak var storagePhone: UITextField!
    @IBOutlet weak var colorPhone: UITextField!
    @IBOutlet weak var costPhone: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    //Добавление нового телефона
    @IBAction func addNewPhone(_ sender: UIButton) {
        if checkValidation(){
            let ref = Database.database().reference().child("phones").child(serialNumberPhone.text!)
            ref.updateChildValues([
                "serialNumber" : serialNumberPhone.text!,
                "model" : modelPhone.text!,
                "memory" : storagePhone.text!,
                "color" : colorPhone.text!,
                "cost" : costPhone.text!
            ])
            self.showAllert(titleText: "Успешно", textString: "Вы добавили новый телефон")
        }
    }
     
    func showAllert(titleText: String,textString: String){
        let alert = UIAlertController(title: titleText, message: textString, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    func checkValidation() -> Bool{
        if serialNumberPhone.text!.count >= 4{
            if modelPhone.text!.count >= 0 && storagePhone.text!.count >= 0 && colorPhone.text!.count >= 0 && costPhone.text!.count >= 0{
                return true
            }else{self.showAllert(titleText: "Ошибка", textString: "Не все поля заполнены")}
        }else{self.showAllert(titleText: "Ошибка", textString: "Серийный номер не может быть меньше 4 значений")}
        return false
    }
}
