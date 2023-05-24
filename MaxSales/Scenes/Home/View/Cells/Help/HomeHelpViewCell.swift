//
//  HomeHelpViewCell.swift
//  MaxSales
//
//  Created by Fabio Miciano on 15/02/23.
//

import Foundation
import UIKit

final class HomeHelpViewCell: HomeCell {
    private lazy var imageHelpView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .white
        imageView.layer.borderColor = UIColor(red: 0.12, green: 0.12, blue: 0.32, alpha: 1.00).cgColor
        imageView.layer.borderWidth = 1.0
        return imageView
    }()
    
    func setup(model: Product, viewModel: HomeCellViewModeling?) {
        buildLayout()
        imageHelpView.image = UIImage(named: model.image)
    }
}

extension HomeHelpViewCell: ViewConfiguration {
    func createHyerarchy() {
        addSubview(imageHelpView)
    }
    
    func setupConstraints() {
        imageHelpView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
