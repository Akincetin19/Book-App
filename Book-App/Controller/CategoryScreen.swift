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
        
        configureView()
        configureScrollView()
        configureStackView()
        createCategoriesButtons()
    }
}
extension CategoryScreen {
    
    func configureView() {
        title = "Kategoriler"
        view.backgroundColor = .white
        view.addSubview(scrollView)
    }
    func configureScrollView() {
        scrollView.addSubview(stackView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    func configureStackView() {
        stackView.anchor(top: scrollView.topAnchor, leading: view.leadingAnchor, bottom: scrollView.bottomAnchor, trailing: view.trailingAnchor,padding: .init(top: 15, left: 16, bottom: 16, right: 16))
        stackView.axis = .vertical
        stackView.spacing = 20
    }
    func createCategoriesButtons() {
        bookService.getCategories {[weak self] result in
            
            guard let self = self else{return}
            switch result {
            case.failure(let error):
                print(error.localizedDescription)
            case.success(let data):
                data.forEach { category in
                    let button = self.createButton(categoryName: category)
                    button.addTarget(self, action: #selector(self.categoryButtonClicked), for: .touchUpInside)
                    self.stackView.addArrangedSubview(button)
                }
            }
        }
    }
    
    @objc fileprivate func categoryButtonClicked(button: UIButton) {
        
        let category = button.titleLabel?.text
        guard let category = category else {
            return
        }
        
        let categoryDetailScreen = CategoryDetailScreen()
        categoryDetailScreen.categoryName = category
        navigationController?.pushViewController(categoryDetailScreen, animated: true)
        
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

