//
//  LogJobViewController.swift
//  PhoneStore
//
//  Created by Blessme on 19.04.2021.
//

import UIKit
import Firebase

class LogJobViewController: UIViewController {

    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    @IBAction func enterJobButton(_ sender: UIButton) {
        if checkTextField(){
            Auth.auth().signIn(withEmail: loginTextField.text!, password: passwordTextField.text!) {(result, error) in
                if error == nil{
                    self.checkPosition()
                }else{
                    self.showAllert(titleText: "Ошибка", textString: "Не верные данные")
                }
            }
            
            
        }else{self.showAllert(titleText: "Ошибка", textString: "Не все поля заполнены")}
    }
    
    //Проверка на валидацыию полей
    func checkTextField() -> Bool{
        if loginTextField.text?.count != 0 && passwordTextField.text?.count != 0 {
            return true
        }
        return false
    }
    //Показ сообщения
    func showAllert(titleText: String,textString: String){
        let alert = UIAlertController(title: titleText, message: textString, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func showNewWindow(window: String){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: window) as UIViewController
        self.present(vc, animated: true, completion: nil)
    }
    //Проверка позиции сотрудника
    func checkPosition(){
        let user = Auth.auth().currentUser
        let userRef = Database.database().reference().child("personal").child(String(user!.uid))
        
        userRef.queryOrderedByKey().observeSingleEvent(of: .value, with: {(snapshot) in
            //Получаем позицию
            let user = snapshot.value as? NSDictionary
            let position = user?["position"] as? String
            
            if position == "admin"{
                self.showNewWindow(window: "mainAdmin")
            }else if position == "storage"{
                self.showNewWindow(window: "mainStorage")
            }
            
            
            
        }) {(error) in
            print(error)
        }
    }
}
