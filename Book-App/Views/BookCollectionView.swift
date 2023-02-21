//
//  BookCollectionView.swift
//  Book-App
//
//  Created by Akın Çetin on 20.02.2023.
//

import UIKit
import Firebase

class BookCollectionView: UICollectionView {
    
    
    private let bookService = BookService()
    var bindableBook = Bindable<Book>()
    private var books: [Book] = []
    
    
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        getBooks()
        
        delegate = self
        dataSource = self
        register(BookCell.self, forCellWithReuseIdentifier: "deneme")
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func getBooks() {
        bookService.downloadBooks {[weak self] result in
            
            guard let self = self else{return}
            switch result {
            case.failure(let error):
                print(error.localizedDescription)
            case.success(let data):
                self.books.append(contentsOf: data)
                self.reloadData()
            }
        }
    }
    
}
extension BookCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return books.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = dequeueReusableCell(withReuseIdentifier: "deneme", for: indexPath) as! BookCell
        cell.configureCell(book: books[indexPath.row])
        if(indexPath.row == books.count - 2) {
            self.getBooks()
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        bindableBook.value = books[indexPath.row]
        
    }
}

extension BookCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (frame.width - 2) / 2
        return CGSize(width: width, height: 475)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
}
