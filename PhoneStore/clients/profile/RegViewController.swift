//
//  RegViewController.swift
//  PhoneStore
//
//  Created by Blessme on 16.04.2021.
//

import UIKit
import Firebase
import FirebaseAuth

class RegViewController: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var imageViewBack: UIImageView!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var numberPhoneTextField: UITextField!
    @IBOutlet weak var mailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordSecondTextField: UITextField!
    
    //Закрытие клавиатуры при нажатии на любую область
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first as? UITouch{
            view.endEditing(true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Закругление углов imageBack
        self.imageViewBack?.clipsToBounds = true
        self.imageViewBack!.layer.cornerRadius = 10
    }
    
    
    
    @IBAction func regButton(_ sender: UIButton) {
        if checkTextField(){
            Auth.auth().createUser(withEmail: mailTextField.text!, password: passwordTextField.text!) {(result, error) in
                if error == nil{
                    if let result = result{
                        let ref = Database.database().reference().child("users")
                        ref.child(result.user.uid).updateChildValues([
                            "name": self.loginTextField.text!,
                            "password": self.passwordTextField.text!,
                            "numberPhone": self.numberPhoneTextField.text!,
                            "mail": self.mailTextField.text!,
                            "uid": result.user.uid
                        ])
                        self.showNewWindow()
                    }
                }else{
                    self.showAllert(titleText: "Ошибка", textString: "Почта уже занята")
                }
            }
        }
    }
    
    
    
    func checkTextField()-> Bool{
        if loginTextField.text?.count != 0{
            if numberPhoneTextField.text?.count == 11{
                if mailTextField.text?.count != 0{
                    if passwordTextField.text!.count >= 6{
                        if passwordTextField.text == passwordSecondTextField.text{
                            return true
                        }else{self.showAllert(titleText: "Ошибка", textString: "Пароли не совпадают")}
                    }else{self.showAllert(titleText: "Ошибка", textString: "пароль не может быть меньше 6 символов")}
                }else{self.showAllert(titleText: "Ошибка", textString: "Почта не заполнена")}
            }else{self.showAllert(titleText: "Ошибка", textString: "Невернно введен мобильный телефон")}
        }else{self.showAllert(titleText: "Ошибка", textString: "Имя не заполнено")}
        return false
    }
    
    func showNewWindow(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "mainView") as UIViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    func showAllert(titleText: String,textString: String){
        let alert = UIAlertController(title: titleText, message: textString, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    @IBAction func backButton(_ sender: UIButton) {
        self.showNewWindow()
    }
}
