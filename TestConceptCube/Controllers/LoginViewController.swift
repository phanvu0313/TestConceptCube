//
//  LoginViewController.swift
//  TestConceptCube
//
//  Created by Vũ Phan on 03/03/2022.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore

class LoginViewController: UIViewController {

   
    @IBOutlet weak var emailTF: UITextField!
    
    @IBOutlet weak var errMess: UILabel!
    
    @IBOutlet weak var passwordTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
   
    @IBAction func didTapLogin(_ sender: Any) {
        validateText()
    }
    
    @IBAction func didTapCreate(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "signUp")
        vc.modalPresentationStyle = .overFullScreen
        present(vc,animated: true)
    }
    private func validateText(){
        if emailTF.text?.isEmpty == true{
            self.errMess.text = "ID is empty"
            return
        }
        if passwordTF.text?.isEmpty == true {
            self.errMess.text = "Password is empty"
            return
        }
        
        login()
        
    }
    private func login(){
        let db = Firestore.firestore()
        
        let docRef = db.collection("users").document(self.emailTF.text!)

        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                print("Document data: \(dataDescription)")
                let pass = document.get("pass")
                if self.passwordTF.text == pass as! String {
                    self.checkUserInfo()
                }else{
                    self.errMess.text = "Password is incorrect"
                }
                
            } else {
                self.errMess.text = "ID does not exist"
                print("Document does not exist")
            }
        }
        
        
        
        
        
    }
    private func checkUserInfo(){
        
        
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "main") as! HomeViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
