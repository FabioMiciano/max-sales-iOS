//
//  ProfileViewModel.swift
//  MaxSales
//
//  Created by Fabio Miciano on 16/02/23.
//

import Foundation

// MARK: -- PROFILE VIEW MODEL DELEGATE --
protocol ProfileViewModelDelegate: AnyObject {
    func loadUser(user: User, purchases: [Product])
    func showError(error: Error)
}

// MARK: -- PROFILE VIEW MODEL PROTOCOL --
protocol ProfileViewModeling: AnyObject {
    var delegate: ProfileViewModelDelegate? { get set }
    
    func getUser()
    func logoutUser()
}

final class ProfileViewModel: ProfileViewModeling {
    weak var delegate: ProfileViewModelDelegate?
    
    private let keychain = KeychainManager()
    
    let service: Requester
    
    init(service: Requester) {
        self.service = service
    }
    
    func getUser() {
        service.requestWith(endPoint: API.user) {[weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(model):
                guard let user: User = self.decodedData(data: model) else { return }
                self.getPurchases(user: user)
            case let .failure(error):
                self.delegate?.showError(error: error)
            }
        }
    }
    
    func getPurchases(user: User) {
        service.requestWith(endPoint: API.purchases) {[weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(model):
                guard let purchases: [Product] = self.decodedData(data: model) else { return }
                self.delegate?.loadUser(user: user, purchases: purchases)
            case let .failure(error):
                self.delegate?.showError(error: error)
            }
        }
    }
    
    func logoutUser() {
        keychain.removeAutoLogin()
    }
}

// MARK: -- PRIVATE FUNCS --
private extension ProfileViewModel {
    func decodedData<T: Decodable>(data: Data) -> T? {
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let model = try decoder.decode(T.self, from: data)
            return model
        } catch {
            self.delegate?.showError(error: error)
            return nil
        }
    }
}
