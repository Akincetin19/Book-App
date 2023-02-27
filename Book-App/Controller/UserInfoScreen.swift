//
//  UserInfoScreen.swift
//  Book-App
//
//  Created by Akın Çetin on 27.02.2023.
//

import UIKit

class UserInfoScreen: UIViewController {

    
    
    private var stackView = UIStackView(frame: .zero)
    
    
    lazy var nameLabel: UILabel = {
       
        let label = UILabel(frame: .zero)
        label.text = "Adınız"
        label.font = .boldSystemFont(ofSize: 16)
        
        return label
    }()
    
    lazy var nameTextField = CustomTextField(placeholderText: "")
    lazy var surnameLabel: UILabel = {
       
        let label = UILabel(frame: .zero)
        label.text = "Soyadınız"
        label.font = .boldSystemFont(ofSize: 16)
        
        return label
    }()
    lazy var surnameTextField = CustomTextField(placeholderText: "")
    lazy var emailLabel: UILabel = {
       
        let label = UILabel(frame: .zero)
        label.text = "E-Posta Adresiniz"
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    lazy var emailTextField = CustomTextField(placeholderText: "")
    
    
    lazy var updateUserInfoButton = CustomLoginButton(title: "Profilimi Güncelle", color: .red)
    
    lazy var nameStackView = UIStackView(arrangedSubviews: [nameLabel, nameTextField])
    lazy var surnameStackView = UIStackView(arrangedSubviews: [surnameLabel, surnameTextField])
    lazy var emailStackView = UIStackView(arrangedSubviews: [emailLabel, emailTextField])
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUserInfo()
        title = "Kişisel Bilgilerim"
        view.addSubview(stackView)
        nameStackView.axis = .vertical
        
        surnameStackView.axis = .vertical
        emailStackView.axis = .vertical
        stackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 16, left: 16, bottom: 0, right: 16))
        stackView.axis = .vertical
        [nameStackView,surnameStackView, emailStackView, updateUserInfoButton].forEach { view in
            stackView.addArrangedSubview(view)
        }
        stackView.spacing = 20
        updateUserInfoButton.addTarget(self, action: #selector(updateUserInfo), for: .touchUpInside)
        
    }
    fileprivate func getUserInfo() {
        UserService.shared.getUserInfo {[weak self] result in
           
            guard let self = self else{return}
            switch result {
            case.failure(let error):
                self.makeAlert(view: self, error: error)
            case.success(let user):
                self.nameTextField.text = user.name
                self.surnameTextField.text = user.surname
                self.emailTextField.text = user.email
            }
        }
    }
    @objc fileprivate func updateUserInfo() {
        
        guard nameTextField.text != "", surnameTextField.text != "", emailTextField.text != "" else {
            self.makeInfoAlert(view: self, info: "Lütfen Tüm Alanları Doldurunuz", title: "")
            return
        }
        guard nameTextField.text!.count > 1, surnameTextField.text!.count > 1, emailTextField.text!.count > 1 else {
            self.makeInfoAlert(view: self, info: "Lütfen Tüm Alanları Doğru Şekilde Doldurunuz", title: "")
            return
        }
        let user = User(name: nameTextField.text!, surname: surnameTextField.text!, email: emailTextField.text!)
        
        UserService.shared.updateUserInfo(user: user) {[weak self] result in
            guard let self = self else {return}
            
            switch result {
            case.failure(let error):
                self.makeAlert(view: self, error: error)
            case.success(let message):
                self.makeInfoAlert(view: self, info: message, title: "")
            }
        }
        
    }
}
