//
//  HomeViewModel.swift
//  MaxSales
//
//  Created by Fabio Miciano on 15/02/23.
//

import Foundation

// MARK: -- PROTOCOLS AND DELEGATES --
protocol HomeViewModelDelegate: AnyObject {
    func productsList(model: [Product])
}

protocol HomeViewModeling: AnyObject {
    var delegate: HomeViewModelDelegate? { get set }
    func loadProducts()
}

// MARK: -- ABSOLUT CLASS --
final class HomeViewModel: HomeViewModeling {
    weak var delegate: HomeViewModelDelegate?
    
    private let service: Requester
    
    init(service: Requester) {
        self.service = service
    }
    
    func loadProducts() {
        service.requestWith(endPoint: API.home) {[weak self] result in
            switch result {
            case let .success(data):
                guard let model = self?.decodedModel(data: data) else { return }
                self?.delegate?.productsList(model: model)
            case let .failure(error):
                print("ERROR = \(error)")
            }
        }
    }
}

// MARK: -- HOME VIEW MODEL --
private extension HomeViewModel {
    func decodedModel(data: Data) -> [Product]? {
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let model = try decoder.decode([Product].self, from: data)
            return model
        } catch {
            return nil
        }
    }
}
