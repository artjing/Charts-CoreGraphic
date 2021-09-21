//
//  AuthManager.swift
//  Flit iOS calculators
//
//  Created by 董静 on 7/22/21.
//

import Foundation
import FirebaseAuth


public class AuthManager{
    
    static let shared = AuthManager()
    let keychain = KeychainSwift()
    
    // register
    public func registerNewUser(email: String?, password: String?, completion: @escaping(Bool)-> Void){
        if let email = email, let password = password{
            FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password) { result, error in
                
                guard result != nil, error == nil else{
                    completion(false)
                    return
                }
                
                // save token
                var token : String?
                result?.user.getIDToken(completion: { string, error in
                    token = string
                })
                TokenManager.shared.saveToken(token: token!)
                print("Register success, refreshToken is :\(String(describing: token))")
                completion(true)
            }
        }
    }
    
    // login
    public func loginWith(email: String?, password: String?, completion: @escaping (Bool) -> Void) {
        if let email = email, let password = password{
            
            FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password) {result, error in
                guard result != nil, error == nil else{
                    completion(false)
                    return
                }
                var token : String?
                result?.user.getIDToken(completion: { string, error in
                    token = string
                })
                
                //TokenManager.shared.saveToken(token: token!)
                print("Login success, refreshToken is :\(String(describing: token))")
                completion(true)
            }
        }
    }
    
    // logout
    public func logOut(completion:(Bool)->Void){
        do{
            try FirebaseAuth.Auth.auth().signOut()
            if TokenManager.shared.clearToken() == true {
                completion(true)
            }
            completion(true)
            print("Logout success")
            return
        }
        catch{
            completion(false)
            return
        }
    }
}
