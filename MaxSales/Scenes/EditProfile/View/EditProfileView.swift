//
//  EditProfileView.swift
//  MaxSales
//
//  Created by Fabio Miciano on 16/02/23.
//

import Foundation
import UIKit
import SwiftUI

protocol EditProfileViewDelegate: AnyObject {
    func updateUser(model: UpdateUser)
}

final class EditProfileView: UIView {
    weak var delegate: EditProfileViewDelegate?
    private var currentUser: User?
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Nome Completo"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Nome Completo"
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.delegate = self
        return textField
    }()
    
    private lazy var mailLabel: UILabel = {
        let label = UILabel()
        label.text = "E-Mail"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    private lazy var mailTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "E-Mail"
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.delegate = self
        textField.keyboardType = .emailAddress
        return textField
    }()
    
    private lazy var passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "Senha"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "*********"
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.isSecureTextEntry = true
        textField.delegate = self
        return textField
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 0.12, green: 0.12, blue: 0.32, alpha: 1.00)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Salvar", for: .normal)
        button.layer.cornerRadius = 4
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(updateAction), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.00)
        buildLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(model: User) {
        nameTextField.text = model.name
        mailTextField.text = model.email
        currentUser = model
    }
}

@objc
private extension EditProfileView {
    func updateAction() {
        let model = UpdateUser(name: nameTextField.text, mail: mailTextField.text, cpf: currentUser?.cpf, password: passwordTextField.text)
        delegate?.updateUser(model: model)
    }
}

extension EditProfileView: ViewConfiguration {
    func createHyerarchy() {
        addSubview(nameLabel)
        addSubview(nameTextField)
        addSubview(mailLabel)
        addSubview(mailTextField)
        addSubview(passwordLabel)
        addSubview(passwordTextField)
        addSubview(saveButton)
    }
    
    func setupConstraints() {
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(Spacing.base01)
            $0.leading.trailing.equalToSuperview().inset(Spacing.base01)
        }
        
        nameTextField.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(Spacing.base01)
            $0.leading.trailing.equalToSuperview().inset(Spacing.base01)
            $0.height.equalTo(Sizing.base06)
        }
        
        mailLabel.snp.makeConstraints {
            $0.top.equalTo(nameTextField.snp.bottom).offset(Spacing.base02)
            $0.leading.trailing.equalToSuperview().inset(Spacing.base01)
        }
        
        mailTextField.snp.makeConstraints {
            $0.top.equalTo(mailLabel.snp.bottom).offset(Spacing.base01)
            $0.leading.trailing.equalToSuperview().inset(Spacing.base01)
            $0.height.equalTo(Sizing.base06)
        }
        
        passwordLabel.snp.makeConstraints {
            $0.top.equalTo(mailTextField.snp.bottom).offset(Spacing.base02)
            $0.leading.trailing.equalToSuperview().inset(Spacing.base01)
        }
        
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(passwordLabel.snp.bottom).offset(Spacing.base01)
            $0.leading.trailing.equalToSuperview().inset(Spacing.base01)
            $0.height.equalTo(Sizing.base06)
        }
        
        saveButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(Spacing.base03)
            $0.height.equalTo(Sizing.base06)
            $0.bottom.equalToSuperview().offset(-Spacing.base12)
        }
    }
}

extension EditProfileView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// MARK: - DEVELOPER PREVIEW -
#if DEBUG
struct EditProfileView_Preview: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            let view = EditProfileView()
            return view
        }
    }
}
#endif
