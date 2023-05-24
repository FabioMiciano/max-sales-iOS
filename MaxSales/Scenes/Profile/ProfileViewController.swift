//
//  ProfileViewController.swift
//  MaxSales
//
//  Created by Fabio Miciano on 16/02/23.
//

import Foundation
import UIKit

final class ProfileViewController: UIViewController {
    private let viewModel: ProfileViewModeling
    private var user: User?
    
    private lazy var profileView: ProfileView = {
        let view = ProfileView()
        view.delegate = self
        return view
    }()
    
    override func loadView() {
        view = profileView
    }
    
    init(viewModel: ProfileViewModeling) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getUser()
    }
}

// MARK: -- PROFILE VIEW DELEGATE --
extension ProfileViewController: ProfileViewDelegate {
    func editUser() {
        guard let user = user else { return }
        let service = ServerRequester()
        let viewModel = EditProfileViewModel(service: service)
        let controller = EditProfileViewController(viewModel: viewModel, model: user)
        controller.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func logoutUser() {
        viewModel.logoutUser()
        tabBarController?.navigationController?.popToRootViewController(animated: true)
    }
}

// MARK: -- PROFILE VIEW MODEL DELEGATE --
extension ProfileViewController: ProfileViewModelDelegate {
    func loadUser(user: User, purchases: [Product]) {
        self.user = user
        profileView.setup(model: user, purchases: purchases)
    }
    
    func showError(error: Error) {
        let snackBar = Snackbar(title: "Não foi possivel carregar as suas informações", type: .error)
        showSnackBar(snackBar)
    }
}
