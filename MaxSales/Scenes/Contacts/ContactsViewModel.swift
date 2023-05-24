//
//  ContactsViewModel.swift
//  MaxSales
//
//  Created by Fabio Miciano on 16/02/23.
//

import Foundation

protocol ContactsViewModelDelegate: AnyObject {}

protocol ContactsViewModeling: AnyObject {
    var delegate: ContactsViewModelDelegate? { get set }
}

final class ContactsViewModel: ContactsViewModeling {
    weak var delegate: ContactsViewModelDelegate?
}
