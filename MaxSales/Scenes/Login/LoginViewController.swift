//
//  LoginViewController.swift
//  MaxSales
//
//  Created by Fabio Miciano on 14/02/23.
//

import Foundation
import UIKit
import SwiftUI

final class LoginViewController: UIViewController {
    private let viewModel: LoginViewModeling
    private let loadingManager = LoadingViewManager()
    private var session: Session?
    
    private lazy var registerService = ServerRequester()
    private lazy var registerViewModel = RegisterViewModel(service: registerService)
    private lazy var registerViewController = RegisterViewController(viewModel: registerViewModel)
    
    private lazy var loginView: LoginView = {
        let view = LoginView()
        view.delegate = self
        view.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.00)
        return view
    }()
    
    override func loadView() {
        view = loginView
    }
    
    init(viewModel: LoginViewModeling) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingManager.start(onTopOf: view)
        let continueLogin = viewModel.autoLogin()
        if !continueLogin {
            loadingManager.stop()
            viewModel.session()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        loginView.clearInputs()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LoginViewController: LoginViewDelegate {
    func loginAction(cpf: String?, password: String?) {
        view.endEditing(true)
        loadingManager.start(onTopOf: view)
        viewModel.login(cpf: cpf, password: password)
    }
    
    func registerAction() {
        if let success = session?.success, success {
            navigationController?.pushViewController(registerViewController, animated: true)
        } else {
            viewModel.contactSac()
        }
    }
}

extension LoginViewController: LoginViewModelDelegate {
    func createSession(session: Session) {
        self.session = session
    }
    
    func loginSuccess() {
        loadingManager.stop()
        let controller = RootTabBarController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func loginError(error: String) {
        loadingManager.stop()
        let snackBar = Snackbar(title: error, type: .error)
        showSnackBar(snackBar)
    }
}

#if DEBUG
struct LoginViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            let viewModel = LoginViewModel(service: ServerRequester())
            let controller = LoginViewController(viewModel: viewModel)
            let navigation = UINavigationController(rootViewController: controller)
            return navigation
        }
    }
}
#endif
