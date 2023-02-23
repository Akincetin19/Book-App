//
//  BookCollectionView.swift
//  Book-App
//
//  Created by Akın Çetin on 20.02.2023.
//

import UIKit
import Firebase

class BookCollectionView: UICollectionView {
    
    
    
    var bindableBook = Bindable<Book>()
    var bindBook = Bindable<Book>()
    var getNewBooks = Bindable<Bool>()
    var books: [Book] = []
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
      
        delegate = self
        dataSource = self
        register(BookCell.self, forCellWithReuseIdentifier: "deneme")
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
            self.getNewBooks.value = true
        }
        cell.bind.bind {[weak self] book in
            guard let self = self, let book = book else {return}
            self.bindBook.value = book
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
