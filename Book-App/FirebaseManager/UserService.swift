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
        let data = ["uid": book.uid,"url": book.Url, "name": book.BookName, "author": book.Author, "count": "1"]
        path.document(userUid).collection("Shopping-Cart").document(book.uid!).setData(data as [String : Any])
    }
    
}
