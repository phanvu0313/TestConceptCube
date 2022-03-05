//
//  SignUpViewController.swift
//  TestConceptCube
//
//  Created by Vũ Phan on 03/03/2022.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore

class SignUpViewController: UIViewController {

    @IBOutlet weak var birthTF: UITextField!
    @IBOutlet weak var errMess: UILabel!
    @IBOutlet weak var pass2: UITextField!
    @IBOutlet weak var email2: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
        
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    

    @IBAction func didTapSignUp(_ sender: Any) {
        if emailTF.text?.isEmpty == true {
            self.errMess.text = "ID is empty"
            return
        }
        if passwordTF.text?.isEmpty == true {
            self.errMess.text = "Password is empty"
            return
        }
        
        if passwordTF.text != pass2.text {
            self.errMess.text = "Password is incorrect"
            return
        }
        
        signUp()
    }
    
    @IBAction func didTapHave(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "loGin")
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
        
    }
    private func signUp(){
        
            let db = Firestore.firestore()
            
            // check ID
            let docRef = db.collection("users").document(self.emailTF.text!)
            
            docRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                    print("Document data: \(dataDescription)")
                    self.errMess.text = "ID already exist"
                    
                } else {
                    // tao auth
                    Auth.auth().createUser(withEmail: self.email2.text!, password: self.passwordTF.text!) { authResult, error in
                        guard let user = authResult?.user,error == nil else {
                            self.errMess.text = error?.localizedDescription
                            return
                        }
                    }
                    db.collection("users").document(self.emailTF.text!).setData([
                        "email": self.email2.text,
                        "birth_day": self.birthTF.text,
                        "pass": self.passwordTF.text,
                    ]) { err in
                        if let err = err {
                            print("Error writing document: \(err)")
                        } else {
                            print("Document successfully written!")
                        }
                    }
                    
                    print("Document does not exist")
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "main")
                    vc.modalPresentationStyle = .overFullScreen
                    self.present(vc, animated: true)
                }
            }
            
            // tao nguoi dung va data
          
            
        
    }
    
}
