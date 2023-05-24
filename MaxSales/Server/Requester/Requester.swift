//
//  Requester.swift
//  MaxSales
//
//  Created by Fabio Miciano on 14/02/23.
//

import Foundation

typealias RequesterCompletion = (Result<Data, Errors>) -> Void

protocol Requester {
    func createURLRequestWith(endPoint: String, method: Method, parameters: [String: Any]?, header: String?) throws -> URLRequest
    func requestWith(endPoint: Endpoint, completion: @escaping RequesterCompletion)
}
