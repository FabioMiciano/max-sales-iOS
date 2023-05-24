//
//  ProductDetailViewController.swift
//  MaxSales
//
//  Created by Fabio Miciano on 21/02/23.
//

import Foundation
import UIKit
import SwiftUI

final class ProductDetailViewController: UIViewController {
    private var model: ProductDetail? = nil
    private var viewModel: ProductDetailViewModeling
    private let loadingManager = LoadingViewManager()
    private let category: CategoryLoadDetail
    
    private lazy var productDetailView: ProductDetailView = {
        let view = ProductDetailView()
        view.delegate = self
        return view
    }()
    
    override func loadView() {
        view = productDetailView
    }
    
    init(category: CategoryLoadDetail, viewModel: ProductDetailViewModeling) {
        self.viewModel = viewModel
        self.category = category
        super.init(nibName: nil, bundle: nil)
        
        title = self.category.title
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.loadProducts(idCategory: category.id)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
}

extension ProductDetailViewController: ProductDetailViewModelDelegate {
    func showProducts(model: [ProductDetail]) {
        productDetailView.setup(dataSource: model, backgroudColor: viewModel.loadBackgroudColor(by: category.title))
    }
}

extension ProductDetailViewController: ProductDetailViewDelegate {
    func selectedPhone(phone: String) {
        guard let appURL = URL(string: "tel://\(phone)") else { return }
        UIApplication.shared.open(appURL)
    }
    
    func selectedController(name: String) {
        guard let factory = DetailFactory(rawValue: name) else { return }
        let controller = factory.make()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func selectedError() {
        let snackBar = Snackbar(title: "Ops, houve um erro, tente novamente mais tarde!", type: .error)
        showSnackBar(snackBar)
    }
    
    func selectedWebView(title: String, path: String) {
        let controller = WebViewController()
        controller.setup(title: title, path: path)
        controller.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(controller, animated: true)
    }
}

// MARK: -- DEVELOPER PREVIEW --
#if DEBUG
struct ProductDetailViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            let viewModel = ProductDetailViewModel(service: ServerRequester())
            let category = CategoryLoadDetail(title: "MAX SAUDE", id: "123")
            let controller = ProductDetailViewController(category: category, viewModel: viewModel)
            let navigation = UINavigationController(rootViewController: controller)
            return navigation
        }
    }
}
#endif
