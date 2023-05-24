//
//  EditProfileViewController.swift
//  MaxSales
//
//  Created by Fabio Miciano on 16/02/23.
//

import Foundation
import UIKit
import SwiftUI

final class EditProfileViewController: UIViewController {
    private lazy var editProfileView: EditProfileView = {
        let view = EditProfileView()
        view.delegate = self
        return view
    }()
    
    private let model: User
    private var viewModel: EditProfileViewModeling
    private let loadingManager = LoadingViewManager()
    
    override func loadView() {
        view = editProfileView
    }
    
    init(viewModel: EditProfileViewModeling, model: User) {
        self.model = model
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Editar Perfil"
        editProfileView.setup(model: model)
        navigationController?.setNavigationBarHidden(false, animated: true)
        viewModel.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

extension EditProfileViewController: EditProfileViewDelegate {
    func updateUser(model: UpdateUser) {
        loadingManager.start(onTopOf: view)
        viewModel.upadateUser(model: model)
    }
}

extension EditProfileViewController: EditProfileViewModelDelegate {
    func updateSuccess() {
        loadingManager.stop()
        let snackBar = Snackbar(title: "Perfil Atualizado com Sucesso", type: .success)
        showSnackBar(snackBar, duration: 1.0) {[weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }
    
    func updateError(error: Error) {
        loadingManager.stop()
        let snackBar = Snackbar(title: error.localizedDescription, type: .error)
        showSnackBar(snackBar)
    }
}

#if DEBUG
struct EditProfile_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            let viewModel = EditProfileViewModel(service: ServerRequester())
            let model = User(id: "0", name: "Fabio Miciano", email: "fabio@ode.com", cpf: "402.580.498-04")
            let controller = EditProfileViewController(viewModel: viewModel, model: model)
            let navigation = UINavigationController(rootViewController: controller)
            return navigation
        }
    }
}
#endif
