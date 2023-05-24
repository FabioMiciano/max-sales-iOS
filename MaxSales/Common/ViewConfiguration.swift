//
//  ViewConfiguration.swift
//  MaxSales
//
//  Created by Fabio Miciano on 14/02/23.
//

import Foundation
import UIKit

protocol ViewConfiguration {
    func buildLayout()
    func createHyerarchy()
    func setupConstraints()
}

extension ViewConfiguration {
    func buildLayout() {
        createHyerarchy()
        setupConstraints()
    }
}
