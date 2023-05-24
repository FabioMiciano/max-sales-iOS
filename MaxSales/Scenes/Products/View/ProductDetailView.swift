//
//  ProductDetailView.swift
//  MaxSales
//
//  Created by Fabio Miciano on 21/02/23.
//

import Foundation
import UIKit
import SwiftUI

// MARK: -- HOME VIEW DELEGATE PROTOCOL --
protocol ProductDetailViewDelegate: AnyObject {
    func selectedWebView(title: String, path: String)
    func selectedPhone(phone: String)
    func selectedController(name: String)
    func selectedError()
}

extension ProductDetailView.Layout {
    enum Size {
        static let collectionSectionInsets = UIEdgeInsets(top: 8, left: 4, bottom: 0, right: 4)
    }
}

final class ProductDetailView: UIView {
    fileprivate enum Layout {}
    
    private var dataSource: [ProductDetail] = []
    weak var delegate: ProductDetailViewDelegate?
    
    private lazy var collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = Layout.Size.collectionSectionInsets
        let collection = UICollectionView(frame: frame, collectionViewLayout: layout)
        collection.register(ProductDetailViewCell.self, forCellWithReuseIdentifier: ProductDetailViewCell.identifier)
        collection.dataSource = self
        collection.delegate = self
        collection.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.00)
        return  collection
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(dataSource: [ProductDetail], backgroudColor: UIColor) {
        self.dataSource = dataSource
        collection.backgroundColor = backgroudColor
        collection.reloadData()
    }
    
    func createCellViewModel() -> ProductDetailViewCellModeling {
        let service = ServerRequester()
        let viewModel = ProductDetailViewCellModel(service: service)
        
        return viewModel
    }
}

extension ProductDetailView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = dataSource[indexPath.row]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductDetailViewCell.identifier, for: indexPath) as? ProductDetailViewCell else {
            return UICollectionViewCell()
        }
        
        cell.setup(model: model, viewModel: createCellViewModel())
        return cell
    }
}

extension ProductDetailView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selected = dataSource[indexPath.row]
        switch selected.linkType {
        case .webView:
            delegate?.selectedWebView(title: selected.title, path: selected.linkAction)
        case .phone:
            delegate?.selectedPhone(phone: selected.linkAction)
        case .controller:
            delegate?.selectedController(name: selected.linkAction)
        default:
            delegate?.selectedError()
        }
        
    }
}

// MARK: -- COLLECTION FLOW LAYOUT DELEGATE --
extension ProductDetailView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height: CGFloat = 100
        let width: CGFloat = frame.size.width - Spacing.base01
        
        return CGSize(width: width, height: height)
    }
}

extension ProductDetailView: ViewConfiguration {
    func createHyerarchy() {
        addSubview(collection)
    }
    
    func setupConstraints() {
        collection.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
