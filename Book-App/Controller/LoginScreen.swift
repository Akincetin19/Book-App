//
//  LoginScreen.swift
//  Book-App
//
//  Created by Akın Çetin on 22.02.2023.
//

import UIKit

class LoginScreen: UIViewController {

    lazy var emailTextField = CustomTextField(placeholderText: "Lütfen Emailinizi Giriniz")
    lazy var passwordTextField = CustomTextField(placeholderText: "Lütfen Şifrenizi Giriniz")

    
    lazy var logInButton = CustomLoginButton(title: "Giriş Yap", color: .blue)
    
    lazy var signInButton = CustomLoginButton(title: "Kayıt Ol", color: .red)
    
    lazy var loginStackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, logInButton, signInButton])
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        view.addSubview(loginStackView)
        
        loginStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 16, left: 16, bottom: 0, right: 16))
        loginStackView.axis = .vertical
        loginStackView.spacing = 20
        signInButton.addTarget(self, action: #selector(goToSignInPage), for: .touchUpInside)
        
    }
    @objc fileprivate func goToSignInPage() {
        
        navigationController?.pushViewController(SignUpScreen(), animated: true)
        
    }
}
