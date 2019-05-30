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
    
    init(navigator: Navigator) {
        self.navigator = navigator
    }
    
    func start() {
        // Instancia da Controller principal
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
        let cardRegisterViewController = CardRegisterViewController()
        cardRegisterViewController.title = " "
        cardRegisterViewController.delegate = self
        cardRegisterViewController.coordinator = self
        
        navigator.push(viewController: cardRegisterViewController, animated: true)
    }
}

extension CardRegisterCoordinator: CardRegisterViewControllerProtocol {
    func cardRegisterViewController(didRegister card: Card) {
        // TODO: Enviar um target para o coordinator anterior para dizer que finalizamos nossa tarefa aqui.
    }
}
