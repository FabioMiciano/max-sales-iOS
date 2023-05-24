//
//  HomeLogoViewCell.swift
//  MaxSales
//
//  Created by Fabio Miciano on 15/02/23.
//

import Foundation
import UIKit

final class HomeLogoViewCell: HomeCell {
    private lazy var logoImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "logoMaxSales"))
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    func setup(model: Product, viewModel: HomeCellViewModeling?) {
        buildLayout()
    }
}

extension HomeLogoViewCell: ViewConfiguration {
    func createHyerarchy() {
        addSubview(logoImage)
    }
    
    func setupConstraints() {
        logoImage.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(Spacing.base01)
        }
    }
}
