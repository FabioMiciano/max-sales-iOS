//
//  LoadingView.swift
//  MaxSales
//
//  Created by Fabio Miciano on 14/02/23.
//

import Foundation
import UIKit

final class LoadingView: UIView {
    private lazy var activity: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .large)
        activity.color = .white
        return activity
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        alpha = 0
        buildLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startLoad() {
        activity.startAnimating()
        UIView.animate(withDuration: 0.3) {
            self.alpha = 0.7
        }
    }
    
    func stopLoad() {
        UIView.animate(withDuration: 0.3) {
            self.alpha = 0
        } completion: { _ in
            self.activity.stopAnimating()
            self.removeFromSuperview()
        }
    }
}

extension LoadingView: ViewConfiguration {
    func createHyerarchy() {
        addSubview(activity)
    }
    
    func setupConstraints() {
        activity.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}

