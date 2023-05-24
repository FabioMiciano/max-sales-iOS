//
//  RegisterViewController.swift
//  MaxSales
//
//  Created by Fabio Miciano on 10/05/23.
//

import Foundation
import UIKit

final class RegisterViewController: UIViewController {
    private lazy var registerView: RegisterView = {
        let view = RegisterView()
        view.delegate = self
        return view
    }()
    
    private var viewModel: RegisterViewModeling
    
    override func loadView() {
        view = registerView
    }
    
    init(viewModel: RegisterViewModeling) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        title = "Criar Usuário"
        self.viewModel.delegate = self
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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


extension RegisterViewController: RegisterViewModelDelegate {
    func registerSuccess(model: Data) {
        let snackBar = Snackbar(title: "Cadastro realizado com sucesso", type: .success)
        showSnackBar(snackBar)
        navigationController?.popToRootViewController(animated: true)
    }
    
    func registerError(error: Error) {
        let snackBar = Snackbar(title: error.localizedDescription, type: .error)
        showSnackBar(snackBar)
    }
}

extension RegisterViewController: RegisterViewDelegate {
    func createUser(model: UpdateUser) {
        viewModel.createUser(model: model)
    }
}

