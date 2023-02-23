//
//  LoginScreen.swift
//  Book-App
//
//  Created by Akın Çetin on 22.02.2023.
//

import UIKit
import JGProgressHUD

class LoginScreen: UIViewController {

    lazy var emailTextField = CustomTextField(placeholderText: "Lütfen Emailinizi Giriniz")
    lazy var passwordTextField = CustomTextField(placeholderText: "Lütfen Şifrenizi Giriniz")

    
    lazy var logInButton = CustomLoginButton(title: "Giriş Yap", color: .blue)
    
    lazy var signInButton = CustomLoginButton(title: "Kayıt Ol", color: .red)
    
    lazy var loginStackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, logInButton, signInButton])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Giriş Yap"
        view.backgroundColor = .white
        view.addSubview(loginStackView)
        
        loginStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 16, left: 16, bottom: 0, right: 16))
        loginStackView.axis = .vertical
        loginStackView.spacing = 20
        signInButton.addTarget(self, action: #selector(goToSignInPage), for: .touchUpInside)
        logInButton.addTarget(self, action: #selector(login), for: .touchUpInside)
        passwordTextField.isSecureTextEntry = true
        
    }
    @objc fileprivate func goToSignInPage() {
        
        navigationController?.pushViewController(SignUpScreen(), animated: true)
    }
    @objc fileprivate func login() {
        
        let isFormValid = emailTextField.text?.isEmpty == false &&
        passwordTextField.text?.isEmpty == false
        
        if(!isFormValid) {
            let hud = JGProgressHUD(style: .dark)
            hud.textLabel.text = "Lütfen Tüm alanları Doldurunuz"
            hud.show(in: self.view)
            hud.dismiss(afterDelay: 2)
        }
        else {
            let hud = JGProgressHUD(style: .dark)
            hud.textLabel.text = "Giriş Yapılıyor"
            hud.show(in: self.view)
            
            AuthService.shared.login(email: emailTextField.text!, password: passwordTextField.text!) { error in
                hud.dismiss()
                self.makeAlert(view: self, error: error)
            }
            hud.dismiss()
            let tabBar = MainTabbarController()
            tabBar.modalPresentationStyle = .fullScreen
            present(tabBar, animated: true)
        }
    }
}
