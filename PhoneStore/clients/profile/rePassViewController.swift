//
//  rePassViewController.swift
//  PhoneStore
//
//  Created by Blessme on 16.04.2021.
//

import UIKit
import Firebase

class rePassViewController: UIViewController {

    @IBOutlet weak var loginTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func rePassButton(_ sender: UIButton) {
        if loginTextField.text?.count != 0{
            
            let email = loginTextField.text!
            Auth.auth().sendPasswordReset(withEmail: email) {(error) in
                if error == nil{
                    self.showAllert(titleText: "Успешно", textString: "Сообщение успешно отправлено на почту")
                }else{
                    self.showAllert(titleText: "Ошибка", textString: "Почта введена неверно")
                    }
                }
            
        }else{
            self.showAllert(titleText: "Ошибка", textString: "Поле (логин) не заполено")
        }
    }
    
    
    func showAllert(titleText: String,textString: String){
        let alert = UIAlertController(title: titleText, message: textString, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
}
