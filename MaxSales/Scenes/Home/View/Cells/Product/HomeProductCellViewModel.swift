//
//  HomeProductCellViewModel.swift
//  MaxSales
//
//  Created by Fabio Miciano on 15/02/23.
//

import Foundation
import UIKit

final class HomeProductCellViewModel: HomeCellViewModeling {
    weak var delegate: HomeCellDelegate?
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
