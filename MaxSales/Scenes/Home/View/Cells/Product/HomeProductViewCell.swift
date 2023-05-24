//
//  HomeProductViewCell.swift
//  MaxSales
//
//  Created by Fabio Miciano on 15/02/23.
//

import Foundation
import UIKit

final class HomeProductViewCell: HomeCell {
    
    // MARK: -- LAZY VARS --
    private lazy var iconImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var title: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private lazy var info: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor(red: 0.30, green: 0.30, blue: 0.30, alpha: 1.00)
        label.numberOfLines = 2
        return label
    }()
    
    // MARK: -- PRIVATE VARS --
    private var viewModel: HomeCellViewModeling?
    
    // MARK: -- SETUP FUNCTION --
    func setup(model: Product, viewModel: HomeCellViewModeling? = nil) {
        buildLayout()
        self.viewModel = viewModel
        self.viewModel?.delegate = self
        self.viewModel?.getImage(name: model.image)
        title.text = model.title
        info.text = model.info
        backgroundColor = .white
        layer.cornerRadius = 5
        layer.masksToBounds = true
    }
}

// MARK: -- VIEW CONFIGURATION --
extension HomeProductViewCell: ViewConfiguration {
    func createHyerarchy() {
        addSubview(iconImage)
        addSubview(title)
        addSubview(info)
    }
    
    func setupConstraints() {
        iconImage.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(Spacing.base00)
            $0.width.height.equalTo(Sizing.base09)
        }
        
        title.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Spacing.base00)
            $0.leading.equalTo(iconImage.snp.trailing).offset(Spacing.base01)
        }

        info.snp.makeConstraints {
            $0.top.equalTo(title.snp.bottom).offset(Spacing.base00).priority(.high)
            $0.leading.equalTo(iconImage.snp.trailing).offset(Spacing.base01)
            $0.trailing.bottom.equalToSuperview().inset(Spacing.base01)
            $0.height.greaterThanOrEqualTo(Sizing.base04)
        }
    }
}

// MARK: -- HOME CELL DELEGATE --
extension HomeProductViewCell: HomeCellDelegate {
    func productImage(image: UIImage) {
        iconImage.image = image
    }
    
    func errorOnImageDownload(error: Error) {
        print("ACHO QUE PODEMOS COLOCAR AQUI UM PLACEHOLDER")
    }
}
