//
//  SignUpScreen.swift
//  Book-App
//
//  Created by Akın Çetin on 22.02.2023.
//

import UIKit
import JGProgressHUD

class SignUpScreen: UIViewController {

    lazy var nameTextField = CustomTextField(placeholderText: "İsminizi Giriniz")
    lazy var lastNameTextField = CustomTextField(placeholderText: "Soyadınızı Giriniz")
    lazy var emailTextField = CustomTextField(placeholderText: "Emailinizi Giriniz")
    lazy var passwordTextField = CustomTextField(placeholderText: "Şifrenizi Giriniz")
    
    lazy var signInButton = CustomLoginButton(title: "Kayıt Ol", color: .blue)
    
    lazy var signInStackView = UIStackView(arrangedSubviews: [nameTextField, lastNameTextField, emailTextField, passwordTextField, signInButton])
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.keyboardType = .emailAddress
        passwordTextField.isSecureTextEntry = true

        view.backgroundColor = .white
        view.addSubview(signInStackView)
        signInStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 16, left: 16, bottom: 0, right: 16))
        signInStackView.axis = .vertical
        signInStackView.spacing = 20
        signInButton.addTarget(self, action: #selector(createUser), for: .touchUpInside)
    }
    @objc fileprivate func createUser() {
        
        let isFormValid = emailTextField.text?.isEmpty == false &&
        passwordTextField.text?.isEmpty == false &&
        nameTextField.text?.isEmpty == false &&
        lastNameTextField.text?.isEmpty == false
        
        if(!isFormValid) {
            let hud = JGProgressHUD(style: .dark)
            hud.textLabel.text = "Lütfen Tüm alanları Doldurunuz"
            hud.show(in: self.view)
            hud.dismiss(afterDelay: 2)
        }
        else {
            //kullanıcı bilgilerini firestore kayıt et
            AuthService.shared.signIn(email: emailTextField.text!, password: passwordTextField.text!)
        }
    }
    func makeAlert(view: UIViewController, error: Error) {
        let dialogMessage = UIAlertController(title: "Hata", message: error.localizedDescription, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Tamam", style: .default)
        dialogMessage.addAction(ok)
        view.present(dialogMessage, animated: true, completion: nil)
    }
}
