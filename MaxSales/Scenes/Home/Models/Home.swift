//
//  Home.swift
//  MaxSales
//
//  Created by Fabio Miciano on 15/02/23.
//

import Foundation

enum HomeCellType: String, Decodable {
    case logo = "logo"
    case help = "help"
    case product = "product"
}

enum ActionType: String, Decodable {
    case webView = "webview"
    case phone = "phone"
    case controller = "controller"
    case none = ""
}

struct Product: Decodable {
    let id: String
    let title: String
    let info: String
    let type: HomeCellType
    let linkType: ActionType
    let linkAction: String
    let image: String
    let available: Bool
}

struct Home{
    let image: String
    let title: String
    let info: String
    let type: HomeCellType
    let linckAction: ActionType?
}
