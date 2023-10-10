//
//  ProductDetailViewModel.swift
//  MaxSales
//
//  Created by Fabio Miciano on 21/02/23.
//

import Foundation
import UIKit

protocol ProductDetailViewModelDelegate: AnyObject {
    func showProducts(model: [ProductDetail])
}

protocol ProductDetailViewModeling {
    var delegate: ProductDetailViewModelDelegate? { get set }
    func loadProducts(idCategory: String)
    func loadBackgroudColor(by category: String) -> UIColor
    func canOpenAppStore(title: String, path: String) -> Bool
}

final class ProductDetailViewModel: ProductDetailViewModeling {
    weak var delegate: ProductDetailViewModelDelegate?
    
    private let service: Requester
    
    init(service: Requester) {
        self.service = service
    }
    
    func loadProducts(idCategory: String) {
        service.requestWith(endPoint: API.products(categoryId: idCategory)) {[weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(data):
                guard let model = self.decodedModel(data: data) else { return }
                self.delegate?.showProducts(model: model)
            case let .failure(error):
                print("ERRO \(error)")
            }
        }
    }
    
    func loadBackgroudColor(by category: String) -> UIColor {
        switch category {
        case "MAX EDUCACIONAL":
            return UIColor(red: 0.98, green: 0.92, blue: 0.77, alpha: 1.00)
        case "MAX SAÚDE":
            return UIColor(red: 0.87, green: 1.00, blue: 0.75, alpha: 1.00)
        case "MAX FIT":
            return UIColor(red: 0.92, green: 0.79, blue: 1.00, alpha: 1.00)
        case "MAX TURISMO":
            return UIColor(red: 0.73, green: 0.91, blue: 1.00, alpha: 1.00)
        case "MAX SEGUROS":
            return UIColor(red: 0.64, green: 0.65, blue: 0.88, alpha: 1.00)
        case "MAX PET":
            return UIColor(red: 1.00, green: 0.97, blue: 0.80, alpha: 1.00)
        default:
            return UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.00)
        }
    }
    
    func canOpenAppStore(title: String, path: String) -> Bool {
        guard let url = URL(string: path), title == "EPHARMA" else { return false }
        UIApplication.shared.open(url)
        return true
    }
}

private extension ProductDetailViewModel {
    func decodedModel(data: Data) -> [ProductDetail]? {
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let model = try decoder.decode([ProductDetail].self, from: data)
            return model
        } catch {
            return nil
        }
    }
}
