//
//  aboutUsViewController.swift
//  PhoneStore
//
//  Created by Blessme on 19.04.2021.
//

import UIKit

class aboutUsViewController: UIViewController {

    @IBOutlet weak var aboutUsTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func sendMessage(_ sender: UIButton) {
        if aboutUsTextField.text?.count != 0 {
            self.showAllert(title: "Отлично", message: "Спасибо за ваш отзыв")
            aboutUsTextField.text = ""
        }else{
            self.showAllert(title: "Ошибка", message: "Вы не можете отправить пустое предложение")
        }
    }
    func showAllert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
