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
        // Verifica se já existe algum cartão de crédito armazenado
        let keychain = KeychainService(key: Card.nameOfClass)
        if let retrivedCard = keychain.retriveObject() as Card? {
            // TODO: Iremos trazer ao contexto direto a tela de pagamento
        } else {
            // Significa que o usuario precisa cadastrar um cartao.
            let childCoordinator = CardRegisterCoordinator(navigator: navigator, contact: contactViewModel)
            childCoordinators.append(childCoordinator)
            childCoordinator.start(keychain: keychain)
        }
    }
}
