//
//  User.swift
//  Book-App
//
//  Created by Akın Çetin on 23.02.2023.
//

import Foundation

struct User {
    
    
    var name: String
    var surname: String
    var email: String
    
    init( name: String, surname: String, email: String) {
        
        self.name = name
        self.surname = surname
        self.email = email
    }
}
