//
//  TokenManager.swift
//  FLITInvest
//
//  Created by 董静 on 8/17/21.
//

import Foundation

class TokenManager {
    
    /*
     Keychain is a pretty secure store strategy.
     Use for store token and password in this project
     Return login state afte unstalling
     */
    
    // Singleton 
    static let shared = TokenManager()
    
    // Inital Keychain
    let keychain = KeychainSwift()

    // Save Token to Keychain
    func saveToken(token: String){
        
        self.keychain.set(token, forKey: FLITPreferenceKeys.FLITLoginToken)
        
    }
    
    // Get Token from Keychain
    func getToken() -> String{
        
        // Get token from keychain
        guard let token = self.keychain.get(FLITPreferenceKeys.FLITLoginToken) else{
            return ""
        }
        return token
        
    }
    
    // Clear Token
    func clearToken() -> Bool{
        self.keychain.delete(FLITPreferenceKeys.FLITLoginToken)
    }
    
}
