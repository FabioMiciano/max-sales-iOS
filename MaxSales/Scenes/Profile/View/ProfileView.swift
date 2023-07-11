//
//  ProfileView.swift
//  MaxSales
//
//  Created by Fabio Miciano on 16/02/23.
//

import Foundation
import UIKit
import SwiftUI
 
// MARK: -- PROFILE VIEW DELEGATE --
protocol ProfileViewDelegate: AnyObject {
    func logoutUser()
    func editUser()
}


// MARK: -- LAYOUT CONSTANTS --
extension ProfileView.Layout {
    enum Size {
       static var profileHeight = 120
    }
}


final class ProfileView: UIView {
    fileprivate enum Layout {}
    private var purchasesDataSource: [Product] = []
    private let cellIdentifier = "pruchase"
    weak var delegate: ProfileViewDelegate?
    
    // MARK: -- LAZY VARS --
    private lazy var profileImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "person.circle.fill"))
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = " - "
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.text = " - "
        label.textAlignment = .center
        label.textColor = UIColor(red: 0.67, green: 0.67, blue: 0.67, alpha: 1.00)
        return label
    }()
    
    private lazy var cpfLabel: UILabel = {
        let label = UILabel()
        label.text = " - "
        label.textAlignment = .center
        label.textColor = UIColor(red: 0.67, green: 0.67, blue: 0.67, alpha: 1.00)
        return label
    }()
    
    private lazy var editButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "pencil.circle"), for: .normal)
        button.addTarget(self, action: #selector(editAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var purchasesLabel: UILabel = {
        let label = UILabel()
        label.text = "MEUS PRODUTOS"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    private lazy var purchasesTable: UITableView = {
        let table = UITableView()
        table.dataSource = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        table.backgroundColor = .clear
        return table
    }()
    
    private lazy var logoutButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sair", for: .normal)
        button.setTitleColor(UIColor(red: 0.88, green: 0.50, blue: 0.22, alpha: 1.00), for: .normal)
        button.layer.borderColor = UIColor(red: 0.88, green: 0.50, blue: 0.22, alpha: 1.00).cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(logoutAction), for: .touchUpInside)
        return button
    }()
    
    // MARK: -- LIFE CICLE --
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.00)
        buildLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(model: User, purchases: [Product]) {
        nameLabel.text = model.name
        emailLabel.text = model.email
        cpfLabel.text = model.cpf
        purchasesDataSource = purchases
        purchasesTable.reloadData()
    }
}

// MARK: -- VIEW CONFIGURATION --
extension ProfileView: ViewConfiguration {
    func createHyerarchy() {
        addSubview(profileImage)
        addSubview(nameLabel)
        addSubview(emailLabel)
        addSubview(cpfLabel)
        addSubview(editButton)
        addSubview(purchasesLabel)
        addSubview(purchasesTable)
        addSubview(logoutButton)
    }
    
    func setupConstraints() {
        profileImage.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview().inset(Spacing.base01)
            $0.height.equalTo(Layout.Size.profileHeight)
        }
        
        editButton.snp.makeConstraints {
            $0.top.equalTo(profileImage.snp.top)
            $0.trailing.equalToSuperview().offset(-Spacing.base01)
            $0.size.equalTo(Sizing.base05)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(profileImage.snp.bottom).offset(Spacing.base03)
            $0.leading.trailing.equalToSuperview().inset(Spacing.base01)
        }
        
        emailLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(Spacing.base01)
            $0.leading.trailing.equalToSuperview().inset(Spacing.base01)
        }
        
        cpfLabel.snp.makeConstraints {
            $0.top.equalTo(emailLabel.snp.bottom).offset(Spacing.base01)
            $0.leading.trailing.equalToSuperview().inset(Spacing.base01)
            $0.height.equalTo(Sizing.base03)
        }
        
        purchasesLabel.snp.makeConstraints {
            $0.top.equalTo(cpfLabel.snp.bottom).offset(Spacing.base04)
            $0.leading.trailing.equalToSuperview().inset(Spacing.base02)
        }
        
        purchasesTable.snp.makeConstraints {
            $0.top.equalTo(purchasesLabel.snp.bottom).offset(Spacing.base01)
            $0.leading.trailing.equalToSuperview().inset(Spacing.base02)
        }
        
        logoutButton.snp.makeConstraints {
            $0.top.equalTo(purchasesTable.snp.bottom).offset(Spacing.base01)
            $0.leading.trailing.equalToSuperview().inset(Spacing.base03)
            $0.height.equalTo(Sizing.base06)
            $0.bottom.equalToSuperview().offset(-Spacing.base12)
        }
    }
}

@objc
private extension ProfileView {
    func logoutAction() {
        delegate?.logoutUser()
    }
    
    func editAction() {
        delegate?.editUser()
    }
}

extension ProfileView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return purchasesDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.backgroundColor = .clear
        var content = cell.defaultContentConfiguration()
        content.text = purchasesDataSource[indexPath.row].title
        cell.contentConfiguration = content
        return cell
    }
}

// MARK: - DEVELOPER PREVIEW -
#if DEBUG
struct ProfileView_Preview: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            let view = ProfileView()
            return view
        }
    }
}
#endif
