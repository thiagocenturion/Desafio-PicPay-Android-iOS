//
//  TransactionCoordinator.swift
//  Desafio-PicPay-Android-iOS
//
//  Created by Avanade on 30/05/19.
//  Copyright © 2019 ThiagoCenturion. All rights reserved.
//

import UIKit

class TransactionCoordinator: CoordinatorProtocol {
    var childCoordinators = [CoordinatorProtocol]()
    var navigator: Navigator
    var contactViewModel: ContactViewModel
    var keychainService: KeychainService
    
    init(navigator: Navigator, contact: ContactViewModel, keychainService: KeychainService) {
        self.navigator = navigator
        self.contactViewModel = contact
        self.keychainService = keychainService
    }
    
    func start() {
        // Verifica se já existe algum cartão de crédito armazenado
        if let retrivedCard = self.keychainService.retriveObject() as Card? {
            // TODO: Iremos trazer ao contexto direto a tela de pagamento
            let payment = Payment(cardNumber: retrivedCard.cardNumber, cvv: retrivedCard.CVV, value: nil, expiryDate: retrivedCard.expiryDate, destinationUserId: nil)
            let viewModel = PaymentViewModel(model: payment, cardViewModel: nil, contactViewModel: contactViewModel)
            let paymentViewController = PaymentViewController(viewModel: viewModel)
            paymentViewController.title = " "
            paymentViewController.delegate = self
            paymentViewController.coordinator = self
            
            // Insere a controller na pilha da navigation
            navigator.push(viewController: paymentViewController, animated: true)
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
        // Identifica se devemos fazer um pop da tela de registro de cartão ou se devemos fazer um push da tela de pagamento
        if navigator.exists(PaymentViewController.self) {
            // Caso já exista alguma controller da tela de pagamento na navigation,
            // significa que devemos realizar um pop do CardRegisterViewController
            navigator.pop(animated: true)
        } else {
            // Se não existe, então a gente instancia e inicia a tela de pagamento
            let viewModel = PaymentViewModel(cardViewModel: cardViewModel, contactViewModel: contactViewModel)
            let paymentViewController = PaymentViewController(viewModel: viewModel)
            paymentViewController.title = " "
            paymentViewController.delegate = self
            paymentViewController.coordinator = self
            
            // Insere a controller na pilha da navigation
            navigator.push(viewController: paymentViewController, animated: true)
        }
    }
}

extension TransactionCoordinator: PaymentViewControllerProtocol {
    func paymentViewController(tappedEditCard cardRegisterViewModel: CardRegisterViewModel) {
        // TODO: Enviar para a tela de edição dos dados de cartão
    }
    
    func paymentViewController(didPayment paymentViewModel: PaymentViewModel) {
        // TODO: Finalizar o pagamento
    }
    
    
}
