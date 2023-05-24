//
//  HomeViewController.swift
//  MaxSales
//
//  Created by Fabio Miciano on 15/02/23.
//

import Foundation
import UIKit
import SwiftUI

final class HomeViewController: UIViewController {
    private let viewModel: HomeViewModeling
    private let service = ServerRequester()
    
    private lazy var homeView: HomeView = {
        let view = HomeView()
        view.delegate = self
        return view
    }()
    
    override func loadView() {
        view = homeView
    }
    
    init(viewModel: HomeViewModeling) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        viewModel.delegate = self
        viewModel.loadProducts()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: -- HOME VIEW MODEL DELEGATE --
extension HomeViewController: HomeViewModelDelegate {
    func productsList(model: [Product]) {
        homeView.setup(dataSource: model)
    }
}

// MARK: -- HOME VIEW DELEGATE --
extension HomeViewController: HomeViewDelegate {
    func selectedController(title: String, type: HomeCellType, id: String) {
        switch type {
        case .help:
            let controller = AboutViewController()
            controller.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(controller, animated: true)
        case .product:
            let viewModel = ProductDetailViewModel(service: service)
            let categoryModel = CategoryLoadDetail(title: title, id: id)
            let controller = ProductDetailViewController(category: categoryModel, viewModel: viewModel)
            controller.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(controller, animated: true)
        default:
            break;
        }
        
        
    }
    
    func selectedSac(url: String) {
        guard let appURL = URL(string: url) else { return }
        UIApplication.shared.open(appURL)
    }
    
    func showWarningSnackBar() {
        let snackBar = Snackbar(title: "Seu plano não está liberado para este serviço.", type: .warning)
        showSnackBar(snackBar)
    }
}

// MARK: -- DEVELOPER PREVIEW --
#if DEBUG
struct HomeViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            let viewModel = HomeViewModel(service: ServerRequester())
            let controller = HomeViewController(viewModel: viewModel)
            let navigation = UINavigationController(rootViewController: controller)
            return navigation
        }
    }
}
#endif
