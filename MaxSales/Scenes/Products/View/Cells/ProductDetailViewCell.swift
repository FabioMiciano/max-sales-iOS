//
//  ProductDetailViewCell.swift
//  MaxSales
//
//  Created by Fabio Miciano on 27/02/23.
//

import Foundation
import UIKit

final class ProductDetailViewCell: UICollectionViewCell {
    static let identifier = String(describing: ProductDetailViewCell.self)
    
    private lazy var imageView: UIImageView = {
        let imagaView = UIImageView()
        imagaView.contentMode = .scaleAspectFit
        imagaView.layer.cornerRadius = 5
        imagaView.layer.masksToBounds = true
        return imagaView
    }()
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.sizeToFit()
        return label
    }()
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.sizeToFit()
        label.numberOfLines = 4
        return label
    }()
    
    // MARK: -- PRIVATE VARS --
    private var viewModel: ProductDetailViewCellModeling?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildLayout()
        backgroundColor = .white
        layer.cornerRadius = 5
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(model: ProductDetail, viewModel: ProductDetailViewCellModeling? = nil) {
        titleLabel.text = model.title
        infoLabel.text = model.info
        self.viewModel = viewModel
        self.viewModel?.delegate = self
        self.viewModel?.getImage(name: model.image)
    }
}

extension ProductDetailViewCell: ViewConfiguration {
    func createHyerarchy() {
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(infoLabel)
    }
    
    func setupConstraints() {
        imageView.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(Spacing.base01)
            $0.width.equalTo(Sizing.base10)
            $0.centerY.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(Spacing.base01)
            $0.leading.equalTo(imageView.snp.trailing).offset(Spacing.base01)
            $0.height.equalTo(Spacing.base02)
        }
        
        infoLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.leading.equalTo(imageView.snp.trailing).offset(Spacing.base01)
            $0.trailing.bottom.equalToSuperview().inset(Spacing.base01)
        }
    }
}

// MARK: -- PRODUCT DETAIL CELL DELEGATE --
extension ProductDetailViewCell: ProductDetailViewCellDelegate {
    func productImage(image: UIImage) {
        imageView.image = image
    }
    
    func errorOnImageDownload(error: Error) {
        print("ACHO QUE PODEMOS COLOCAR AQUI UM PLACEHOLDER")
    }
}
