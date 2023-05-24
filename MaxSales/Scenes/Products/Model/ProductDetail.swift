//
//  ProductDetail.swift
//  MaxSales
//
//  Created by Fabio Miciano on 21/02/23.
//

import Foundation

struct CategoryLoadDetail {
    let title: String
    let id: String
}

struct ProductDetail: Decodable {
    let title: String
    let info: String
    let linkType: ActionType
    let linkAction: String
    let image: String
}
