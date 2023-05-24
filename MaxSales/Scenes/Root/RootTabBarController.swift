//
//  RootTabBarController.swift
//  MaxSales
//
//  Created by Fabio Miciano on 14/02/23.
//

import Foundation
import UIKit

final class RootTabBarController: UITabBarController {
    private let service = ServerRequester()
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBar()
        navigationController?.setNavigationBarHidden(true, animated: true)
        
    }
    
    private func configureTabBar() {
        viewControllers = [
            setupHomeScreen(),
            setupProfileScreen(),
            setupContactsScreen()
        ]
    }
    
    private func setupHomeScreen() -> UINavigationController {
        let viewModel = HomeViewModel(service: service)
        let controller = HomeViewController(viewModel: viewModel)
        let navigation = UINavigationController(rootViewController: controller)
        navigation.tabBarItem.image = UIImage(systemName: "house")
        navigation.tabBarItem.title = "Home"
        navigation.isNavigationBarHidden = true
        return navigation
    }
    
    private func setupProfileScreen() -> UINavigationController {
        let viewModel = ProfileViewModel(service: service)
        let controller = ProfileViewController(viewModel: viewModel)
        let navigation = UINavigationController(rootViewController: controller)
        navigation.tabBarItem.image = UIImage(systemName: "person")
        navigation.tabBarItem.title = "Perfil"
        navigation.isNavigationBarHidden = true
        return navigation
    }
    
    private func setupContactsScreen() -> UINavigationController {
        let viewModel = ContactsViewModel()
        let controller = ContatcsViewController(viewModel: viewModel)
        let navigation = UINavigationController(rootViewController: controller)
        navigation.tabBarItem.image = UIImage(systemName: "envelope")
        navigation.tabBarItem.title = "Contato"
        navigation.isNavigationBarHidden = true
        return navigation
    }
}
