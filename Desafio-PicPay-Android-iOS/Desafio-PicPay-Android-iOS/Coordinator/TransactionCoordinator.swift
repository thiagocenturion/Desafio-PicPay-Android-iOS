//
//  TransactionCoordinator.swift
//  Desafio-PicPay-Android-iOS
//
//  Created by Avanade on 30/05/19.
//  Copyright © 2019 ThiagoCenturion. All rights reserved.
//

import UIKit

class TransactionCoordinator: NSObject, CoordinatorProtocol {
    var childCoordinators = [CoordinatorProtocol]()
    var navigator: Navigator
    var contactViewModel: ContactViewModel
    var cardRegisterViewModel: CardRegisterViewModel
    var keychainService: KeychainService
    
    init(navigator: Navigator, contact: ContactViewModel) {
        super.init()
        self.navigator = navigator
        self.contactViewModel = contact
    }
    
    func start(keychainService: KeychainService = KeychainService(key: Card.nameOfClass)) {
        self.keychainService = keychainService
        // Verifica se já existe algum cartão de crédito armazenado
        if let retrivedCard = self.keychainService.retriveObject() as Card? {
            // TODO: Iremos trazer ao contexto direto a tela de pagamento
        } else {
            // Enviamos para a tela de priming de cartão de cadastro, que o levara para o formulario de cadastro.
            let cardPrimingViewController = CardPrimingViewController()
            cardPrimingViewController.title = " "
            cardPrimingViewController.delegate = self
            cardPrimingViewController.coordinator = self
            
            // Insere a controller na pilha da navigation
            navigator.push(viewController: cardPrimingViewController, animated: true)
        }
    }
}

extension TransactionCoordinator: CardPrimingViewControllerProtocol {
    func cardPrimingViewControllerOnRegister() {
        // Instancia da controller que possui o formulário
        let viewModel = CardRegisterViewModel(keychainService: keychainService)
        let cardRegisterViewController = CardRegisterViewController(viewModel: viewModel)
        cardRegisterViewController.title = " "
        cardRegisterViewController.delegate = self
        cardRegisterViewController.coordinator = self
        
        // Insere a controller na pilha da navigation
        navigator.push(viewController: cardRegisterViewController, animated: true)
    }
}

extension TransactionCoordinator: CardRegisterViewControllerProtocol {
    func cardRegisterViewController(didRegister cardViewModel: CardRegisterViewModel) {
        // TODO: Enviar um target para o coordinator anterior para dizer que finalizamos nossa tarefa aqui.
    }
}
