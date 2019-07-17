//
//  PaymentViewModel.swift
//  Desafio-PicPay-Android-iOS
//
//  Created by Avanade on 03/07/19.
//  Copyright © 2019 ThiagoCenturion. All rights reserved.
//

import UIKit

class PaymentViewModel {
    
    // MARK: - Properties
    
    private(set) var valueViewModel = TextFieldViewModel()
    private(set) var cardViewModel: CardRegisterViewModel?
    private(set) var contactViewModel: ContactViewModel?
    private(set) var payment: Payment
    var isCounted = Dynamic(false)
    var alertMessage = Dynamic("")
    
    // MARK: Constructors
    
    init(model: Payment = Payment(cardNumber: nil, cvv: nil, value: nil, expiryDate: nil, destinationUserId: nil), cardViewModel: CardRegisterViewModel?, contactViewModel: ContactViewModel?) {
        self.payment = model
        self.cardViewModel = cardViewModel
        self.contactViewModel = contactViewModel
        setupBind()
    }
    
    // MARK: - Methods
    
    func setupBind() {
        // Define os binds quando os text fields recebem um texto novo de entrada
        valueViewModel.text.bind { [weak self] text in
            // Determina se o texto esta dentro da contagem necessaria para que o campo esteja validado para prosseguir
            self?.valueViewModel.calculateMinimumCountValid(text: text)
            
            // Atribui a model o texto digitado na tela. Se existir, remove a mascara.
            var formattedText = text
            if let mask = self?.valueViewModel.mask, let replacement = self?.valueViewModel.replacement {
                formattedText = text.removeFormatted(mask: mask, replacmentCharacter: Character(replacement))
            }
            self?.payment.value = Float(formattedText)
        }
        
        // Binds de quando as propriedades de validação de contagem minima e maxima sao redefinidas. Nos atualizamos as mensagens de erro de cada um dos text fields, de volta para a controller
        valueViewModel.isCounted.bind { [weak self] _ in self?.updateCountedAndErrorMessage(self?.valueViewModel) }
        
        // Model -> ViewModel
        if let value = payment.value { valueViewModel.text.value = String(value) }
    }
    
    func updateCountedAndErrorMessage(_ viewModel: TextFieldViewModel?) {
        // Atualiza o contador geral informando se todos os campos já foram digitados até a sua quantidade minima
        isCounted.value = valueViewModel.isCounted.value
        
        // Remove a mensagem de erro
        viewModel?.errorMessage.value = nil
    }
    
}
