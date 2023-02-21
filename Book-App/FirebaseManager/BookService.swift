//
//  BookService.swift
//  Book-App
//
//  Created by Akın Çetin on 20.02.2023.
//

import Foundation
import Firebase

class BookService {
    
    
    let firebase = Firestore.firestore()
    var lastBook: Book?
    
    func downloadBooks(completion: @escaping (Result<[Book], Error>) -> ()) {
        
        var books: [Book] = []
        
        let query = firebase.collection("Books").order(by: "uid").start(after: [lastBook?.uid as Any]).limit(to: 10)
        query.getDocuments { snapshot, error in
            
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(error))
                return
            }
            guard let snapshot = snapshot else {return}
            
            let data = snapshot.documents
            
            data.forEach { item in
                
                var book = Book()
                book.uid = item["uid"] as? String
                book.BookName = item["bookName"] as? String
                book.Url = item["imageUrl"] as? String
                book.Price = item["bookPrice"] as? String
                book.Kind = item["kind"] as? String
                book.Description = item["bookDescription"] as? String
                book.Author = item["author"] as? String
                books.append(book)
                self.lastBook = book
            }
            completion(.success(books))
        }
         
    }
}
