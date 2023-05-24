//
//  ProductDetailViewModel.swift
//  MaxSales
//
//  Created by Fabio Ferreira Da Rocha Miciano on 04/03/23.
//

import Foundation
import UIKit

protocol ProductDetailViewCellDelegate: AnyObject {
    func productImage(image: UIImage)
    func errorOnImageDownload(error: Error)
}

protocol ProductDetailViewCellModeling {
    var delegate: ProductDetailViewCellDelegate?{ get set }
    func getImage(name: String)
}

final class ProductDetailViewCellModel: ProductDetailViewCellModeling {
    weak var delegate: ProductDetailViewCellDelegate?
    private let service: Requester
    
    init(service: Requester) {
        self.service = service
    }
    
    func getImage(name: String) {
        service.requestWith(endPoint: API.image(name: name)) {[weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(data):
                guard let image = UIImage(data: data) else { return }
                self.delegate?.productImage(image: image)
            case let .failure(error):
                self.delegate?.errorOnImageDownload(error: error)
            }
        }
    }
}
