//
//  LoginView.swift
//  MaxSales
//
//  Created by Fabio Miciano on 14/02/23.
//

import Foundation
import UIKit
import SwiftUI
import InputMask

protocol LoginViewDelegate: AnyObject {
    func loginAction(cpf: String?, password: String?)
    func registerAction()
}

final class LoginView: UIView {
    weak var delegate: LoginViewDelegate?
    
    private lazy var logoImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "logoMaxSalesLauch"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var cpfLabel: UILabel = {
        let label = UILabel()
        label.text = "CPF"
        label.font = UIFont.boldSystemFont(ofSize: 17)
        return label
    }()
    
    private lazy var cpfInput: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "___.___.___-__"
        textField.delegate = self
        textField.keyboardType = .numberPad
        return textField
    }()
    
    private lazy var passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "Senha"
        label.font = UIFont.boldSystemFont(ofSize: 17)
        return label
    }()
    
    private lazy var passwordInput: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "*********"
        textField.isSecureTextEntry = true
        textField.delegate = self
        return textField
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 0.12, green: 0.12, blue: 0.32, alpha: 1.00)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Entrar", for: .normal)
        button.layer.cornerRadius = 4
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var registerLabel: UILabel = {
        let label = UILabel()
        label.text = "Não tem uma conta com a gente?"
        label.textAlignment = .center
        label.textColor = UIColor(red: 0.88, green: 0.50, blue: 0.22, alpha: 1.00)
        return label
    }()
    
    private lazy var registerButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor(red: 0.12, green: 0.12, blue: 0.32, alpha: 1.00), for: .normal)
        button.setTitle("Entre em contato", for: .normal)
        button.contentHorizontalAlignment = .center
        button.addTarget(self, action: #selector(registerAction), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        endEditing(true)
    }
    
    func clearInputs() {
        cpfInput.text = ""
        passwordInput.text = ""
    }
}

extension LoginView: ViewConfiguration {
    func createHyerarchy() {
        addSubview(logoImage)
        addSubview(cpfLabel)
        addSubview(cpfInput)
        addSubview(passwordLabel)
        addSubview(passwordInput)
        addSubview(loginButton)
        addSubview(registerLabel)
        addSubview(registerButton)
    }
    
    func setupConstraints() {
        logoImage.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).offset(Spacing.base02)
            $0.leading.trailing.equalToSuperview().inset(Spacing.base03)
            $0.height.equalTo(200)
        }
        
        cpfLabel.snp.makeConstraints {
            $0.top.equalTo(logoImage.snp.bottom).offset(Spacing.base05)
            $0.leading.trailing.equalToSuperview().inset(Spacing.base01)
        }
        
        cpfInput.snp.makeConstraints {
            $0.top.equalTo(cpfLabel.snp.bottom).offset(Spacing.base00)
            $0.leading.trailing.equalToSuperview().inset(Spacing.base01)
            $0.height.equalTo(Sizing.base05)
        }
        
        passwordLabel.snp.makeConstraints {
            $0.top.equalTo(cpfInput.snp.bottom).offset(Spacing.base02)
            $0.leading.trailing.equalToSuperview().inset(Spacing.base01)
        }
        
        passwordInput.snp.makeConstraints {
            $0.top.equalTo(passwordLabel.snp.bottom).offset(Spacing.base00)
            $0.leading.trailing.equalToSuperview().inset(Spacing.base01)
            $0.height.equalTo(Sizing.base05)
        }
        
        loginButton.snp.makeConstraints {
            $0.top.equalTo(passwordInput.snp.bottom).offset(Spacing.base03)
            $0.leading.trailing.equalToSuperview().inset(Spacing.base01)
            $0.height.equalTo(Sizing.base06)
        }
        
        registerLabel.snp.makeConstraints {
            $0.top.equalTo(loginButton.snp.bottom).offset(Spacing.base04)
            $0.leading.trailing.equalToSuperview().inset(Spacing.base01)
        }
        
        registerButton.snp.makeConstraints {
            $0.top.equalTo(registerLabel.snp.bottom).offset(Spacing.base01)
            $0.leading.trailing.equalToSuperview().inset(Spacing.base01)
            $0.height.equalTo(Sizing.base06)
        }
    }
}

extension LoginView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true}
        if string.isEmpty { return true }
        let inputText: String = (text as NSString).replacingCharacters(in: range, with: string)
        if textField == cpfInput {
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

@objc
extension LoginView {
    func loginAction() {
        delegate?.loginAction(cpf: cpfInput.text, password: passwordInput.text)
    }
    
    func registerAction() {
        delegate?.registerAction()
    }
}

// MARK: - DEVELOPER PREVIEW -
#if DEBUG
struct LoginView_Preview: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            let view = LoginView()
            return view
        }
    }
}
#endif
