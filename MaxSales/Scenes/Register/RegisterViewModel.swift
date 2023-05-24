//
//  RegisterViewModel.swift
//  MaxSales
//
//  Created by Fabio Miciano on 10/05/23.
//

import Foundation

protocol RegisterViewModelDelegate: AnyObject {
    func registerSuccess(model: Data)
    func registerError(error: Error)
}

protocol RegisterViewModeling {
    var delegate: RegisterViewModelDelegate? { get set }
    func createUser(model: UpdateUser)
}

final class RegisterViewModel: RegisterViewModeling {
    weak var delegate: RegisterViewModelDelegate?
    private let service: Requester
    
    init(service: Requester) {
        self.service = service
    }
    
    func createUser(model: UpdateUser) {
        service.requestWith(endPoint: API.register(model: model)) {[weak self] result in
            switch result {
            case let .success(model):
                self?.delegate?.registerSuccess(model: model)
            case let .failure(error):
                self?.delegate?.registerError(error: error)
            }
        }
    }
}
