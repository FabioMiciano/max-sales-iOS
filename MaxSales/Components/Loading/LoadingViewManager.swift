//
//  LoadingViewManager.swift
//  MaxSales
//
//  Created by Fabio Miciano on 14/02/23.
//

import Foundation
import UIKit

final class LoadingViewManager {
    private lazy var loadingView = LoadingView()
    
    func start(onTopOf view: UIView) {
        setupLayout(loadingView, superview: view)
        loadingView.startLoad()
    }
    
    func stop() {
        loadingView.stopLoad()
    }
    
    private func setupLayout(_ loadingView: LoadingView, superview: UIView) {
        superview.addSubview(loadingView)
        
        loadingView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
