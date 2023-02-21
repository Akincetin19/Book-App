//
//  AuthService.swift
//  Book-App
//
//  Created by Akın Çetin on 22.02.2023.
//

import Foundation
import Firebase

class AuthService {
    
    let authPath = Auth.auth()
    
    static var shared = AuthService()
    
    private init(){}
    func signIn(email: String, password: String) {
     
        authPath.createUser(withEmail: email, password: password)
    }
    
}
