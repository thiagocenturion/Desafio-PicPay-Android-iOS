//
//  CardRegisterCoordinator.swift
//  Desafio-PicPay-Android-iOS
//
//  Created by Avanade on 30/05/19.
//  Copyright © 2019 ThiagoCenturion. All rights reserved.
//

import UIKit

class CardRegisterCoordinator: NSObject, CoordinatorProtocol {
    var childCoordinators = [CoordinatorProtocol]()
    var navigator: Navigator
    var contactViewModel: ContactViewModel
    var keychain: KeychainService
    
    init(navigator: Navigator, contact: ContactViewModel) {
        super.init()
        self.navigator = navigator
        self.contactViewModel = contact
    }
    
    func start(keychain: KeychainService = KeychainService(key: Card.nameOfClass)) {
        self.keychain = keychain

        // Enviamos para a tela de priming de cartão de cadastro, que o levara para o formulario de cadastro.
        let cardPrimingViewController = CardPrimingViewController()
        cardPrimingViewController.title = " "
        cardPrimingViewController.delegate = self
        cardPrimingViewController.coordinator = self
        
        // Insere a controller na pilha da navigation
        navigator.push(viewController: cardPrimingViewController, animated: true)
    }
}

extension CardRegisterCoordinator: CardPrimingViewControllerProtocol {
    func cardPrimingViewControllerOnRegister() {
        // Instancia da controller que possui o formulário
        let model = Card(cardNumber: nil, holdersName: nil, expiryDate: nil, CVV: nil)
        let viewModel = CardRegisterViewModel(model: model, keychainService: keychain)
        let cardRegisterViewController = CardRegisterViewController(viewModel: viewModel)
        cardRegisterViewController.title = " "
        cardRegisterViewController.delegate = self
        cardRegisterViewController.coordinator = self
        
        navigator.push(viewController: cardRegisterViewController, animated: true)
    }
}

extension CardRegisterCoordinator: CardRegisterViewControllerProtocol {
    func cardRegisterViewController(didRegister cardViewModel: CardRegisterViewModel) {
        // TODO: Enviar um target para o coordinator anterior para dizer que finalizamos nossa tarefa aqui.
    }
}
