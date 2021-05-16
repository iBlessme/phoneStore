
//  ProfileViewController.swift
//  PhoneStore
//
//  Created by Blessme on 16.04.2021.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import MobileCoreServices

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageBackIngo: UIImageView!
    @IBOutlet weak var imageProfileView: UIImageView!
    @IBOutlet weak var nameProfileLabel: UILabel!
    @IBOutlet weak var mailProfileLabel: UILabel!
    @IBOutlet weak var numberPhoneLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        self.imageBackIngo?.clipsToBounds = true
        self.imageBackIngo!.layer.cornerRadius = 10
        
        imageProfileView.layer.borderWidth = 1.0
        imageProfileView.layer.masksToBounds = false
        imageProfileView.layer.borderColor = UIColor.white.cgColor
        imageProfileView.layer.cornerRadius = imageProfileView.frame.size.width / 2
        imageProfileView.clipsToBounds = true
        
        self.checkPerson()
        
    }
    
    //Изменение фотографии пользователя
    @IBAction func changeProfileImage(_ sender: UIButton) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.mediaTypes = [kUTTypeImage as String]
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.allowsEditing = false
        present(imagePickerController, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let capturedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageProfileView.contentMode = .scaleAspectFit
            imageProfileView.image = capturedImage
            self.uploadPhotoInStorage()
        }
        dismiss(animated: true, completion: nil)
    }
    func uploadPhotoInStorage(){
        let user = Auth.auth().currentUser
        let uid: String = user!.uid
        let ref = Storage.storage().reference().child("users").child(uid)
        
        guard let imageData = imageProfileView.image?.jpegData(compressionQuality: 0.4) else { return }
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        _ = ref.putData(imageData, metadata: metadata) {(metadata, error) in
            guard let metadata = metadata else {return}
            _ = metadata.size
            ref.downloadURL {(url, error) in
                guard let downloadURL = url else {return}
            }
        }
    }
    
    //Выход из аккаунта
    @IBAction func exitProfile(_ sender: UIButton) {
        do{
            try Auth.auth().signOut()
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(identifier: "LogViewController") as UIViewController
            self.present(vc, animated: true, completion: nil)
        }catch{
            print("Ошибка при выходе")
        }
    }
    
    //Проверка на авторизацию пользователя
    func checkPerson(){
        Auth.auth().addStateDidChangeListener{(auth, user) in
            if user == nil{
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let vc = storyboard.instantiateViewController(identifier: "LogViewController") as UIViewController
                self.present(vc, animated: true, completion: nil)
            }else{
                self.loadProfile()
                        }
                }
    }
    
    //Загрузка профиля
    func loadProfile(){
        self.loadPhoto()
        let user = Auth.auth().currentUser
        let usersRef = Database.database().reference().child("users").child(String(user!.uid))
        usersRef.queryOrderedByKey().observeSingleEvent(of: .value, with: {(snapshot) in
            //Получаем профиль
            let user = snapshot.value as? NSDictionary
            
            let name = user?["name"] as? String
            self.nameProfileLabel.text = name
            
            let numberPhone = user?["numberPhone"] as? String
            self.numberPhoneLabel.text = numberPhone
            
            let email = user?["mail"] as? String
            self.mailProfileLabel.text = email
        }) {(error) in
            print(error)
        }
        
    }
    
    //Загрузка изображения
    func loadPhoto(){
        let userUid: String = Auth.auth().currentUser!.uid
        let ref = Storage.storage().reference().child("users").child(String(userUid))
        
        let megabite = Int64(1 * 1024 * 1024)
        ref.getData(maxSize: megabite) {(data, error) in
            
            guard let imageData = data else {return}
            let image = UIImage(data: imageData)
            self.imageProfileView.image = image
            
        }
    }
}
