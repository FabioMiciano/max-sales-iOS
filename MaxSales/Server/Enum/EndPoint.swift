//
//  EndPoint.swift
//  MaxSales
//
//  Created by Fabio Miciano on 14/02/23.
//

import Foundation

protocol Endpoint {
    var path: String { get }
    var method: Method { get }
    var parameters: [String: Any]? { get }
    var header: String? { get }
}

