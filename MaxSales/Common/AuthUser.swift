//
//  AuthUser.swift
//  MaxSales
//
//  Created by Fabio Miciano on 14/02/23.
//

import Foundation

class AuthUser {
    static let shared = AuthUser()
    private var token: String = ""
    
    func set(token: String) {
        self.token = token
    }
    
    func getToken() -> String {
        return token
    }
}

