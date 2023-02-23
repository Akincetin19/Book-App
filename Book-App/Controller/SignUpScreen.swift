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
        title  = "Kayıt Ol"
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
            let hud = JGProgressHUD(style: .dark)
            hud.textLabel.text = "Kaydınız Oluşturuluyor"
            hud.show(in: self.view)
            
            
            let user = User(name: nameTextField.text!, surname: lastNameTextField.text!, email: emailTextField.text!)
            AuthService.shared.signIn(user: user, password: passwordTextField.text!) {[weak self] error in
                
                guard let self = self else{return}
                hud.dismiss()
                self.makeAlert(view: self, error: error)
            }
            hud.textLabel.text = "Kaydınız Oluşturuldu"
            hud.dismiss(afterDelay: 2)
            navigationController?.popViewController(animated: true)
        }
    }
}
