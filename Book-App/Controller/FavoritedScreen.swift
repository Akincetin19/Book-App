//
//  FavoritedScreen.swift
//  Book-App
//
//  Created by Akın Çetin on 26.02.2023.
//

import UIKit

class FavoritedScreen: UIViewController {

    var favoritedBooks: [Book]?
    
    lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        return layout
    }()
    
    lazy var collectionView = BookCollectionView(frame: .zero, collectionViewLayout: layout)
    
    override func viewWillAppear(_ animated: Bool) {
        getBooks()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        
        title = "Favorilerim"
        view.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor)
        setupSelectBookObserver()
        addBasketButtonClickedFromCollectionViewCell()
    }
    func getBooks() {
        UserService.shared.getFavoritedBooks { book in
            self.favoritedBooks = book
            self.collectionView.books = book
            self.collectionView.reloadData()
        }
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
    fileprivate func addBasketButtonClickedFromCollectionViewCell() {
        collectionView.bindBook.bind {[weak self] book in
            guard let self = self, let book = book else {return}
            
            UserService.shared.addShoppingCart(book: book)
            self.makeInfoAlert(view: self, info: "", title: "Ürün Sepetinize Eklendi")
            
        }
        
    }
}
