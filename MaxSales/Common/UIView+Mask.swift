//
//  UIView+Mask.swift
//  MaxSales
//
//  Created by Fabio Miciano on 14/02/23.
//

import Foundation
import InputMask

extension UIView {
    func maskString(input: String, mask: String) -> String {
        do {
            let mask = try Mask(format: mask)
            let result: Mask.Result = mask.apply(toText: CaretString(string: input), autocomplete: true)
            return result.formattedText.string
        } catch {
            return input
        }
    }
}
