//
//  RegisterView.swift
//  MaxSales
//
//  Created by Fabio Miciano on 10/05/23.
//

import Foundation
import UIKit

protocol RegisterViewDelegate: AnyObject {
    func createUser(model: UpdateUser)
}

final class RegisterView: UIView {
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
    
    private lazy var cpfLabel: UILabel = {
        let label = UILabel()
        label.text = "CPF"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    private lazy var cpfTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "___.___.___-__"
        textField.delegate = self
        textField.keyboardType = .numberPad
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
    
    private lazy var registerButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 0.12, green: 0.12, blue: 0.32, alpha: 1.00)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Criar Usuário", for: .normal)
        button.layer.cornerRadius = 4
        button.layer.masksToBounds = true
        button.contentHorizontalAlignment = .center
        button.addTarget(self, action: #selector(registerAction), for: .touchUpInside)
        return button
    }()
    
    weak var delegate: RegisterViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildLayout()
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RegisterView: ViewConfiguration {
    func createHyerarchy() {
        addSubview(nameLabel)
        addSubview(nameTextField)
        addSubview(cpfLabel)
        addSubview(cpfTextField)
        addSubview(mailLabel)
        addSubview(mailTextField)
        addSubview(passwordLabel)
        addSubview(passwordTextField)
        addSubview(registerButton)
    }
    
    func setupConstraints() {
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(Spacing.base02)
            $0.leading.trailing.equalToSuperview().inset(Spacing.base01)
        }
        
        nameTextField.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(Spacing.base01)
            $0.leading.trailing.equalToSuperview().inset(Spacing.base01)
            $0.height.equalTo(Sizing.base06)
        }
        
        cpfLabel.snp.makeConstraints {
            $0.top.equalTo(nameTextField.snp.bottom).offset(Spacing.base02)
            $0.leading.trailing.equalToSuperview().inset(Spacing.base01)
        }
        
        cpfTextField.snp.makeConstraints {
            $0.top.equalTo(cpfLabel.snp.bottom).offset(Spacing.base01)
            $0.leading.trailing.equalToSuperview().inset(Spacing.base01)
            $0.height.equalTo(Sizing.base06)
        }
        
        mailLabel.snp.makeConstraints {
            $0.top.equalTo(cpfTextField.snp.bottom).offset(Spacing.base02)
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
        
        registerButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(Spacing.base03)
            $0.height.equalTo(Sizing.base06)
            $0.bottom.equalToSuperview().offset(-Spacing.base12)
        }
    }
}

@objc
private extension RegisterView {
    func registerAction() {
        let model = UpdateUser(
            name: nameTextField.text,
            mail: mailTextField.text?.lowercased(),
            cpf: cpfTextField.text,
            password: passwordTextField.text
        )
        delegate?.createUser(model: model)
    }
}

extension RegisterView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true}
        if string.isEmpty { return true }
        let inputText: String = (text as NSString).replacingCharacters(in: range, with: string)
        if textField == cpfTextField {
            textField.text = maskString(input: inputText, mask: "[000].[000].[000]-[00]")
            return false
        }
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
