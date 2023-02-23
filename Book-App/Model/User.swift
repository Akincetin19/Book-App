//
//  User.swift
//  Book-App
//
//  Created by Akın Çetin on 23.02.2023.
//

import Foundation

struct User {
    
    
    let name: String
    let surname: String
    let email: String
    
    init( name: String, surname: String, email: String) {
        
        self.name = name
        self.surname = surname
        self.email = email
    }
}
