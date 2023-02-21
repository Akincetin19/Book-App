//
//  Book.swift
//  Book-App
//
//  Created by Akın Çetin on 20.02.2023.
//

import Foundation


struct Books: Decodable {
    var books: [Book]
}

struct Book:Decodable {
    
    var uid: String?
    var Category: String?
    var BookName: String?
    var Author: String?
    var Description: String?
    var Kind: String?
    var Url: String?
    var Price: String?
    
    
    
}
