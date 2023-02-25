//
//  CartScreen.swift
//  Book-App
//
//  Created by Akın Çetin on 23.02.2023.
//

import UIKit

class CartScreen: UIViewController {

    let tableView = CartTableView(frame: .zero, style: .grouped)
   
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(tableView)
        
        tableView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        title = "Sepetim"
        view.backgroundColor = .white
        
        self.tableView.bindIsUserCreateNewOrder.bind {[weak self] bool in
            guard let self = self else {return}
            self.makeInfoAlert(view: self
                               , info: "Ana Sayfaya Yönlendiriliyorsunuz"
                               , title: " Siparişiniz Başarıyla Oluşturuldu")
            self.tabBarController?.selectedIndex = 0
        }
        
        self.tableView.bindableIsDelete.bind {[weak self] bool in
            guard let self = self else {return}
            self.makeInfoAlert(view: self, info: "Ürün Başarıyla Sepetinizde Silindi", title: "")
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        UserService.shared.getShoppingChart {[weak self] result in
            guard let self = self else {return}
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let books):
                self.tableView.books = books
                self.tableView.reloadData()
            }
        }
    }
}
