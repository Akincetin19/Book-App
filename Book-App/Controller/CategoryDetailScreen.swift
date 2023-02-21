//
//  CategoryDetailScreen.swift
//  Book-App
//
//  Created by Akın Çetin on 21.02.2023.
//

import UIKit

class CategoryDetailScreen: UIViewController {

    
    var categoryName: String?
    
    lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        return layout
    }()
    
    lazy var collectionView = BookCollectionView(frame: .zero, collectionViewLayout: layout)
    private let service = BookService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = categoryName
        view.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor)
        getBooks()
        getNewBook()
        goToBookDetail()
        
    }
    private func getBooks() {
        
        service.getCategoryBook(category: categoryName!) {[weak self] result in
         
            guard let self = self else{return}
            switch result {
            case.failure(let error):
                print(error.localizedDescription)
            case.success(let data):
                self.collectionView.books.append(contentsOf: data)
                self.collectionView.reloadData()
            }
        }
    }
    private func getNewBook() {
        collectionView.getNewBooks.bind {[weak self] bool in
            guard let self = self else{return}
            self.getBooks()
        }
    }
    private func goToBookDetail() {
        
        collectionView.bindableBook.bind {[weak self] book in
            guard let self = self else{return}
            guard let book = book else{return}
            let bookDetail = BookDetailPage()
            bookDetail.selectedBook = book
            
            self.navigationController?.pushViewController(bookDetail, animated: true)
            
        }
    }
}
