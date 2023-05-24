//
//  SpaceLevel.swift
//  MaxSales
//
//  Created by Fabio Miciano on 14/02/23.
//

import Foundation

protocol NoneScale {
    associatedtype NoneType
    static var none: NoneType { get }
}

protocol BaseValue {
    associatedtype BaseType
    static var base00: BaseType { get }
    static var base01: BaseType { get }
    static var base02: BaseType { get }
    static var base03: BaseType { get }
    static var base04: BaseType { get }
    static var base05: BaseType { get }
    static var base06: BaseType { get }
    static var base07: BaseType { get }
    static var base08: BaseType { get }
    static var base09: BaseType { get }
    static var base10: BaseType { get }
    static var base11: BaseType { get }
    static var base12: BaseType { get }
}

protocol SpaceLevel: NoneScale & BaseValue { }
