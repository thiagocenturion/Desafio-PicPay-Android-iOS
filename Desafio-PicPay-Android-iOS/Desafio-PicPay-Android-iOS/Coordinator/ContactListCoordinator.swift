//
//  ContactListCoordinator.swift
//  Desafio-PicPay-Android-iOS
//
//  Created by Avanade on 17/05/19.
//  Copyright © 2019 ThiagoCenturion. All rights reserved.
//

import UIKit

class ContactListCoordinator: NSObject, CoordinatorProtocol {
    var childCoordinators = [CoordinatorProtocol]()
    var navigator: Navigator
    
    init(navigator: Navigator) {
        self.navigator = navigator
    }
    
    func start() {
        // Instancia da Controller principal
        let contactListViewController = ContactListViewController()
        contactListViewController.title = " "
        contactListViewController.delegate = self
        contactListViewController.coordinator = self
        
        // Insere a controller na pilha da navigation
        navigator.push(viewController: contactListViewController, animated: true)
    }
}

extension ContactListCoordinator: ContactListViewControllerProtocol {
    func contactListViewController(didSelect contactViewModel: ContactViewModel) {
        let childCoordinator = CardRegisterCoordinator(navigator: navigator)
        childCoordinators.append(childCoordinator)
        childCoordinator.start()
    }
}
