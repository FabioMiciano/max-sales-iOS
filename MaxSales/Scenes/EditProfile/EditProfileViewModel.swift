//
//  EditProfileViewModel.swift
//  MaxSales
//
//  Created by Fabio Miciano on 16/02/23.
//

protocol EditProfileViewModelDelegate: AnyObject {
    func updateSuccess()
    func updateError(error: Error)
}

protocol EditProfileViewModeling {
    var delegate: EditProfileViewModelDelegate? { get set }
    func upadateUser(model: UpdateUser)
}


final class EditProfileViewModel: EditProfileViewModeling {
    weak var delegate: EditProfileViewModelDelegate?
    private let keychain = KeychainManager()
    
    private let service: Requester
    
    init(service: Requester) {
        self.service = service
    }
    
    func upadateUser(model: UpdateUser) {
        service.requestWith(endPoint: API.update(model: model)) {[weak self] result in
            switch result {
            case .success:
                if let cpf = model.cpf, let password = model.password {
                    self?.keychain.removeAutoLogin()
                    self?.keychain.saveAutoLogin(cpf: cpf, password: password)
                }
                self?.delegate?.updateSuccess()
            case let .failure(error):
                self?.delegate?.updateError(error: error)
            }
        }
    }
}
