//
//  API.swift
//  MaxSales
//
//  Created by Fabio Miciano on 14/02/23.
//

import Foundation

enum API: Endpoint {
    case login(cpf: String, password: String)
    case home
    case user
    case purchases
    case products(categoryId: String)
    case image(name: String)
    case update(model: UpdateUser)
    case session
    case register(model: UpdateUser)
    
    var path: String {
        switch self {
        case .login:
            return "session"
        case .home:
            return "home"
        case .purchases:
            return "users/purchases"
        case .user, .update:
            return "users"
        case let .image(name):
            return "files/\(name)"
        case let .products(categoryId):
            return "products/\(categoryId)"
        case .session:
            return "newSession"
        case .register:
            return "newUser"
        }
    }
    
    var method: Method {
        switch self {
        case .login, .register, .session:
            return .post
        case .home, .image, .user, .purchases, .products:
            return .get
        case .update:
            return .put
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case let .login(cpf, password):
            return ["cpf": cpf, "password": password]
        case let .update(model):
            return ["name": model.name ?? "", "cpf": model.cpf ?? "", "email": model.mail ?? "", "password": model.password ?? ""]
        case let .register(model):
            return ["name": model.name ?? "", "cpf": model.cpf ?? "", "email": model.mail ?? "", "password": model.password ?? ""]
        default:
            return nil
        }
    }
    
    var header: String? {
        switch self {
        case .session:
            guard let version = Bundle.main.infoDictionary?["CFBundleVersion"] as? String else { return nil }
            return "\(version)"
        case .home, .user, .update, .purchases, .products:
            return "Bearer \(AuthUser.shared.getToken())"
        default:
            return nil
        }
    }
}
