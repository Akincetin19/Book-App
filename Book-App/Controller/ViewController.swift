//
//  ViewController.swift
//  Book-App
//
//  Created by Akın Çetin on 20.02.2023.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        return layout
    }()
    private let bookService = BookService()
    lazy var collectionView = BookCollectionView(frame: .zero, collectionViewLayout: layout)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        title = "Ana Sayfa"
        getBooks()
        setupCollectionView()
        setupSelectBookObserver()
        addBasketButtonClickedFromCollectionViewCell()
        
    }
    fileprivate func addBasketButtonClickedFromCollectionViewCell() {
        collectionView.bindBook.bind {[weak self] book in
            guard let self = self, let book = book else {return}
            UserService.shared.addShoppingCart(book: book)
            self.makeInfoAlert(view: self, info: "", title: "Ürün Sepetinize Eklendi")
            
        }
    }
    fileprivate func setupView() {
        view.backgroundColor = .white
    }
    
    fileprivate func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor)
    }
    fileprivate func setupSelectBookObserver() {
        collectionView.bindableBook.bind {[weak self] book in
            
            guard let self = self else{return}
            
            guard let book = book else{return}
            let bookDetail = BookDetailPage()
            bookDetail.selectedBook = book
            self.navigationController?.pushViewController(bookDetail, animated: true)
        }
        collectionView.getNewBooks.bind {[weak self] bool in

            guard let self = self else{return}
            self.getBooks()
        }
    }
    func getBooks() {
        bookService.downloadBooks {[weak self] result in
            
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
}

