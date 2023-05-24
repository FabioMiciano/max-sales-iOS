//
//  UIViewController+Snackbar.swift
//  MaxSales
//
//  Created by Fabio Miciano on 14/02/23.
//

import Foundation
import UIKit

extension UIViewController {
    func showSnackBar(_ snackBar: Snackbar, onTopOf topview: UIView? = nil, duration: TimeInterval = 2.0, completion: (()->Void)? = nil) {
        guard let topview = topview ?? view else {
            return
        }
        
        SnackBarManager().show(snackBar, onTopof: topview, duration: duration, completion: completion)
    }
}
