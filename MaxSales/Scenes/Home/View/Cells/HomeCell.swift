//
//  HomeCell.swift
//  MaxSales
//
//  Created by Fabio Miciano on 15/02/23.
//

import Foundation
import UIKit

typealias HomeCell = UICollectionViewCell & HomeCellSetup

protocol HomeCellSetup {
    func setup(model: Product, viewModel: HomeCellViewModeling?)
}

protocol HomeCellViewModeling {
    var delegate: HomeCellDelegate? { get set }
    func getImage(name: String)
}

protocol HomeCellDelegate: AnyObject {
    func productImage(image: UIImage)
    func errorOnImageDownload(error: Error)
}
