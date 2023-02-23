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
    let firebase = Firestore.firestore()
    
    static var shared = AuthService()
    
    private init(){}
    func signIn(user: User, password: String, completion: @escaping (Error) ->()) {
     
        authPath.createUser(withEmail: user.email, password: password) { result, error in
            if let error = error {
                completion(error)
                return
            }
            guard let result = result else{return}
            
            self.saveUserInfo(user: user, uid: result.user.uid)
        }
    }
    private func saveUserInfo(user: User, uid: String) {
        
        let data = ["email": user.email, "name": user.name, "uid": uid, "surname" : user.surname]
        firebase.collection("Users").document(uid).setData(data)
    }
    func login(email: String, password: String, completion: @escaping (Error)->()) {
        
        authPath.signIn(withEmail: email, password: password) { _, error in
            if let error = error {
                completion(error)
                return
            }
        }
    }
    
}
