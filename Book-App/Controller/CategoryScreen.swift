//
//  CategoryScreen.swift
//  Book-App
//
//  Created by Akın Çetin on 21.02.2023.
//

import UIKit

class CategoryScreen: UIViewController {

    
    let bookService = BookService()
    private let stackView = UIStackView(frame: .zero)
    
    private let scrollView = UIScrollView(frame: .zero)
    var buttons:[UIButton] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        title = "Kategoriler"
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        stackView.anchor(top: scrollView.topAnchor, leading: view.leadingAnchor, bottom: scrollView.bottomAnchor, trailing: view.trailingAnchor,
                         padding: .init(top: 15, left: 16, bottom: 16, right: 16))
        
        stackView.axis = .vertical
        stackView.spacing = 20
        bookService.getCategories {[weak self] result in
            
            guard let self = self else{return}
            switch result {
            case.failure(let error):
                print(error.localizedDescription)
            case.success(let data):
                data.forEach { category in
                    let button = self.createButton(categoryName: category)
                    self.stackView.addArrangedSubview(button)
                    
                }
            }
        }
    }
    fileprivate func createButton(categoryName: String) -> UIButton {
        
        let button = UIButton(frame: .zero)
        button.setTitle(categoryName, for: .normal)
        button.layer.cornerRadius = 16
        button.backgroundColor = .blue
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return button
        
    }
}
