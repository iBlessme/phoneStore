//
//  LogViewController.swift
//  PhoneStore
//
//  Created by Blessme on 16.04.2021.
//

import UIKit
import Firebase
import FirebaseAuth

class LogViewController: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var imageViewBack: UIImageView!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
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
    //кнопка ввхода
    @IBAction func enterLogButton(_ sender: UIButton) {
        if checkText(){
            Auth.auth().signIn(withEmail: loginTextField.text!, password: passwordTextField.text!) {(result, error) in
                if error == nil{
                    self.showNewWindow()
                }
                else{
                    self.showAllert(titleText: "Ошибка", textString: "Неверный логин или пароль")
                }
                
            }
        }else{
            self.showAllert(titleText: "Ошибка", textString: "не все поля заполены")
        }
    }
    //кнопка востановления пароля
    @IBAction func rePassButton(_ sender: UIButton) {
        
    }
    
    
    
    func checkText() -> Bool {
        if loginTextField.text?.count != 0 && passwordTextField.text?.count != 0{
            return true
        }else{
            return false
        }
    }
    func showAllert(titleText: String,textString: String){
        let alert = UIAlertController(title: titleText, message: textString, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    func showNewWindow(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "mainView") as UIViewController
        self.present(vc, animated: true, completion: nil)
    }
    @IBAction func backButton(_ sender: UIButton) {
        self.showNewWindow()
    }
}
