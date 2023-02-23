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
        
    }
    
}
