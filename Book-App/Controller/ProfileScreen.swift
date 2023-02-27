//
//  ProfileScreen.swift
//  Book-App
//
//  Created by Akın Çetin on 26.02.2023.
//

import UIKit

class ProfileScreen: UIViewController {

    fileprivate let topStackView = UIStackView(frame: .zero)
    fileprivate let userNameLabel: UILabel = {
       
        let label = UILabel(frame: .zero)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20)
        label.text = "Merhaba Akın Çetin"
        return label
    }()
    
    fileprivate let lineView: UIView = {
       
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor.init(red: 71/255, green: 78/255, blue: 104/255, alpha: 1)
        return view
    }()
    
    fileprivate var books: [Book] = []

    override func viewDidLoad() {
        
        super.viewDidLoad()
        getBooks()
        setView()
        setButtons()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Çıkış Yap", style: .plain, target: self, action: #selector(logOut))

    }
}
extension ProfileScreen {
    
    @objc func logOut() {
        let result = try? AuthService.shared.logOut()
        guard let result = result else {return}
        if result{
            let vc = LoginScreen()
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        }
        else {
            self.makeInfoAlert(view: self, info: "Hata Meydana Geldi", title: "")
        }
    }
    
    func setView() {
        view.addSubview(lineView)
        view.addSubview(userNameLabel)
        
        lineView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, size: .init(width: 0, height: 1))
        
        userNameLabel.anchor(top: lineView.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 32, left: 0, bottom: 0, right: 0))
    }
    
    func setButtons() {
        let ordersButton = createButton(title: "Siparişlerim")
        view.addSubview(ordersButton)
        ordersButton.anchor(top: userNameLabel.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 16, left: 16, bottom: 0, right: 16), size: .init(width: 0, height: 50))
        
        let favoritedButton = createButton(title: "Favorilerim")
        view.addSubview(favoritedButton)
        favoritedButton.anchor(top: ordersButton.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 16, left: 16, bottom: 0, right: 16), size: .init(width: 0, height: 50))
        favoritedButton.addTarget(self, action: #selector(goToFavoritedScreen), for: .touchUpInside)
        
        let userInfoButton = createButton(title: "Kişisel Bilgilerim")
        view.addSubview(userInfoButton)
        userInfoButton.anchor(top: favoritedButton.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 16, left: 16, bottom: 0, right: 16), size: .init(width: 0, height: 50))
        userInfoButton.addTarget(self, action: #selector(goToUserInfoScreen), for: .touchUpInside)
    }
    
    func getBooks() {
        UserService.shared.getFavoritedBooks {[weak self] books in
            guard let self = self else {return}
            self.books = books
        }
    }
    func createButton(title: String) -> UIButton {
        let button = UIButton(frame: .zero)
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 8
        button.layer.borderColor = CGColor.init(red: 71/255, green: 78/255, blue: 104/255, alpha: 1)
        return button
    }
    @objc func goToFavoritedScreen() {
        let vc = FavoritedScreen()
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc func goToUserInfoScreen() {
        let vc = UserInfoScreen()
        navigationController?.pushViewController(vc, animated: false)
    }
}
