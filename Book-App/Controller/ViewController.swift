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
    lazy var collectionView = BookCollectionView(frame: .zero, collectionViewLayout: layout)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupCollectionView()
        setupSelectBookObserver()
        
        
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
    }
    
    /*
    func loadJson(filename fileName: String) -> [Book]? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(Books.self, from: data)
                return jsonData.books
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
    func writeFirebase() {
        let books = loadJson(filename: "data")
        
        let firebase = Firestore.firestore().collection("Books")
        
        
        books?.forEach({ book in
            let uid = UUID().uuidString
            let data = ["bookName" : book.BookName,
                        "kind": book.Kind,
                        "author" : book.Author,
                        "bookDescription" : book.Description,
                        "bookPrice" : book.Price,
                        "imageUrl" : book.Url,
                        "uid": uid]
            firebase.addDocument(data: data)
        })
    }
     */
}

