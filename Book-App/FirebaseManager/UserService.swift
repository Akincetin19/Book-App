//
//  UserService.swift
//  Book-App
//
//  Created by Akın Çetin on 23.02.2023.
//

import Foundation
import Firebase

class UserService {

    static var shared = UserService()
    private var userUid = Auth.auth().currentUser?.uid
    private var path = Firestore.firestore().collection("Users")
    private init(){}
    
    func addShoppingCart(book: Book) {
        
        guard let userUid = userUid else {return}
        let data = ["uid": book.uid,"url": book.Url, "name": book.BookName, "author": book.Author, "count": "1", "bookPrice": book.Price]
        path.document(userUid).collection("Shopping-Cart").document(book.uid!).setData(data as [String : Any])
    }
    func getShoppingChart(completion: @escaping (Result<[CartBook], Error>) -> ()){
        
        var books: [CartBook] = []
        guard let userUid = userUid else {return}
        path.document(userUid).collection("Shopping-Cart").getDocuments { query, error in
            if let error = error {
                completion(.failure(error))
            }
            guard let query = query else {return}
            let data = query.documents
            
            data.forEach { item in
                let name =  item["name"]
                let author =  item["author"]
                let count = item["count"]
                let uid = item["uid"]
                let url = item["url"]
                let bookPrice = item["bookPrice"]
                
                var book = CartBook()
                book.count = count as? String
                book.url = url as? String
                book.uid = uid as? String
                book.author = author as? String
                book.name = name as? String
                book.bookPrice = bookPrice as? String
                
                books.append(book)
            }
            completion(.success(books))
        }
    }
    func deleteBookFromChart(book: CartBook) {
        path.document(userUid!).collection("Shopping-Cart").document(book.uid!).delete()
    }
    func updateChart(book: CartBook) {
        
        let data = ["uid": book.uid,"url": book.url, "name": book.name, "author": book.author, "count": book.count, "bookPrice" : book.bookPrice]
        path.document(userUid!).collection("Shopping-Cart").document(book.uid!).setData(data as [String : Any])
    }
    func createNewOrder(books: [CartBook] , totalPrice: Int) {
            
        let uid = UUID().uuidString
        books.forEach { book in
            let data = ["uid": book.uid,"url": book.url, "name": book.name, "author": book.author, "count": book.count, "bookPrice": book.bookPrice]
            path.document(userUid!).collection("Orders").document(uid).collection("Books").addDocument(data: data as [String : Any])
            path.document(userUid!).collection("Shopping-Cart").document(book.uid!).delete()
        }
    }
    func isFavorited(book: Book, completion: @escaping (Bool) -> ()) {
        
        let favoritedPath = path.document(userUid!).collection("Favorited")
        favoritedPath.document(book.uid!).getDocument { query, error in
            if error != nil {
                return
            }
            guard let query = query else {return}
            let data = query.data()
            guard data != nil else{
                completion(false)
                return
            }
            
            completion(true)
        }
    }
    func removeFromFavorited(book: Book) {
        
        let favoritedPath = path.document(userUid!).collection("Favorited")
        favoritedPath.document(book.uid!).getDocument { query, error in
            if error != nil {
                return
            }
            guard let query = query else {return}
            let data = query.data()
            guard data != nil else{
                return
            }
            favoritedPath.document(book.uid!).delete()
        }
    }
    func addFavoritedBook(book: Book) {
        guard let userUid = userUid else {return}
        let data = ["uid": book.uid,"url": book.Url, "name": book.BookName, "author": book.Author,"bookPrice": book.Price]
        path.document(userUid).collection("Favorited").document(book.uid!).setData(data as [String : Any])
    }
    func getFavoritedBooks(completion: @escaping ([Book])->()){
        
        var books: [Book] = []
        
        let favoritedPath = path.document(userUid!).collection("Favorited")
        favoritedPath.getDocuments { query, error in
            if error != nil {
                return
            }
            guard let query = query else {return}
            
            let data = query.documents
            
            data.forEach { item in
                var book = Book()
                book.uid = item["uid"] as? String
                book.BookName = item["name"] as? String
                book.Author = item["author"] as? String
                book.Url = item["url"] as? String
                book.Price = item["bookPrice"] as? String
                
                books.append(book)
            }
            completion(books)
        }
    }
}
