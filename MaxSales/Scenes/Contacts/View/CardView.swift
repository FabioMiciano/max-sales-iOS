//
//  CardView.swift
//  MaxSales
//
//  Created by Fabio Miciano on 16/02/23.
//

import Foundation
import UIKit
import SwiftUI

enum CardViewaActioType {
    case mail
    case webpage
    case phoneNumber
}

struct CardViewConfiguration {
    let title: String
    let info: String
    let type: CardViewaActioType
}

final class CardView: UIView {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 17.0)
        return label
    }()
    
    private lazy var infoLabel: UIButton = {
        let button = UIButton()
        button.titleLabel?.textAlignment = .center
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(actionButton), for: .touchUpInside)
        return button
    }()
    
    let configuration: CardViewConfiguration
    
    init(configuration: CardViewConfiguration) {
        self.configuration = configuration
        super.init(frame: .zero)
        buildLayout()
        configureLayout()
        layer.masksToBounds = true
        layer.cornerRadius = 10
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CardView: ViewConfiguration {
    func configureLayout() {
        backgroundColor = .white
        titleLabel.text = configuration.title
        infoLabel.setTitle(configuration.info, for: .normal)
    }
    
    func createHyerarchy() {
        addSubview(titleLabel)
        addSubview(infoLabel)
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().offset(Spacing.base01)
            $0.top.equalToSuperview().offset(Spacing.base03)
        }
        
        infoLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().offset(Spacing.base01)
            $0.top.equalTo(titleLabel.snp.bottom).offset(Spacing.base01)
            $0.bottom.equalToSuperview().offset(-Spacing.base02)
        }
    }
}

private extension CardView {
    @objc func actionButton() {
        switch configuration.type {
        case .phoneNumber:
            guard let url = URL(string: "tel://\(configuration.info)") else { return }
            UIApplication.shared.open(url)
        case .mail:
            guard let url = URL(string: "mailto:\(configuration.info)") else { return }
            UIApplication.shared.open(url)
        case .webpage:
            guard let url = URL(string: "https://\(configuration.info)") else { return }
            UIApplication.shared.open(url)
        }
    }
}

// MARK: - DEVELOPER PREVIEW -
struct CardView_Preview: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            let view = CardView(configuration: CardViewConfiguration(title: "SAC", info: "08005911946", type: .phoneNumber))
            return view
        }
    }
}
