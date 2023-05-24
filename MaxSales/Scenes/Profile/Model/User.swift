//
//  User.swift
//  MaxSales
//
//  Created by Fabio Miciano on 16/02/23.
//

import Foundation

struct User: Decodable {
    let id: String
    let name: String
    let email: String
    let cpf: String
}
