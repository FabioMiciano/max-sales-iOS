//
//  Login.swift
//  MaxSales
//
//  Created by Fabio Miciano on 14/02/23.
//

import Foundation

struct Login: Decodable {
    let id: String
    let cpf: String
    let token: String
}

struct Session: Decodable {
    let success: Bool
    let sessionID: String
}
