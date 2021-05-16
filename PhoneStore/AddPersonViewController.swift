//
//  AddPersonViewController.swift
//  PhoneStore
//
//  Created by Blessme on 01.05.2021.
//

import UIKit
import Firebase

class AddPersonViewController: UIViewController {

    @IBOutlet weak var namePersonTextField: UITextField!
    @IBOutlet weak var mailPersonTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var positionPersonSegment: UISegmentedControl!
    
    var mailAdmin: String = ""
    var passwordAdmin: String = ""
    
    
    //Закрытие клавиатуры при нажатии на любую область
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first as? UITouch{
            view.endEditing(true)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.readerSavedAcc()
    }
    
    
    //Сохраняем данные предыдущего пользователя
    func readerSavedAcc(){
        let user = Auth.auth().currentUser
        let userRef = Database.database().reference().child("personal").child(String(user!.uid))
        userRef.queryOrderedByKey().observeSingleEvent(of: .value, with: {(snapshot) in
            
            let user = snapshot.value as? NSDictionary
            
            let mail = user?["mail"] as? String
            let pass = user?["password"] as? String
            
            self.mailAdmin = mail!
            self.passwordAdmin = pass!
        })
        
    }
    //Функция входа в аккаунт
    func enterAcc(){
        Auth.auth().signIn(withEmail: mailAdmin, password: passwordAdmin)
        print("mail: \(mailAdmin)")
    }
    
    //Добавление новго пользователя
    @IBAction func addPersonAction(_ sender: UIButton)
    {
        if checkValidation(){
            Auth.auth().createUser(withEmail: mailPersonTextField.text!, password: passwordTextField.text!) {(result, error) in
                if error == nil{
                    if let result = result{
                        let ref = Database.database().reference().child("personal")
                        ref.child(result.user.uid).updateChildValues([
                            "name" : self.namePersonTextField.text!,
                            "mail" : self.mailPersonTextField.text!,
                            "password" : self.passwordTextField.text!,
                            "position" : self.checkSegmentItem()
                        ])
                        self.showAllert(title: "Успешно", message: "Сотрудник добавлен")
                        self.enterAcc()
                    }else{
                        self.showAllert(title: "Ошибка", message: "Что-то пошло не так")
                    }
                }
            }
        }else{self.showAllert(title: "Ошибка", message: "Что-то произошло не так как надо")}
        
    }
    
    //Проверка полей
    func checkValidation() -> Bool{
        if namePersonTextField.text!.count > 0{
            if mailPersonTextField.text!.count > 0{
                if passwordTextField.text!.count > 6{
                    return true
                }else{
                    self.showAllert(title: "Ошибка", message: "Пароль должен быть не меньше 6 символов")}
            }else{self.showAllert(title: "Ошибка", message: "Введите почту")}
        }else{self.showAllert(title: "Ошибка", message: "Введите имя")}
        return false
    }
    
    
    //Проверяем выбранную позицию
    func checkSegmentItem() -> String{
        let position: String
        
        switch positionPersonSegment.selectedSegmentIndex {
        case 0:
            position = "admin"
            return position
        case 1:
            position = "storage"
            return position
        default:
            return "nil"
        }
    }
    
    
    func showAllert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
}
