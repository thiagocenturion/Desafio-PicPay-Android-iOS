//
//  CardPrimingViewModel.swift
//  Desafio-PicPay-Android-iOS
//
//  Created by Avanade on 30/05/19.
//  Copyright © 2019 ThiagoCenturion. All rights reserved.
//

import Foundation

class CardRegisterViewModel {
    
    // MARK: - Properties
    
    private(set) var cardNumberViewModel = TextFieldViewModel(mask: "#### #### #### #### ###", replacement: "#", minimumCount: 13)
    private(set) var holdersNameViewModel = TextFieldViewModel()
    private(set) var expiryDateViewModel = TextFieldViewModel(mask: "##/##", replacement: "#")
    private(set) var cvvViewModel = TextFieldViewModel()
    private(set) var card: Card
    var isCounted = Dynamic(false)
    var alertMessage = Dynamic("")
    private var isValid: Bool {
        get {
            return cardNumberViewModel.validate(.creditCard)
                    && holdersNameViewModel.validate(.name)
                    && expiryDateViewModel.validate(.expiryDate(formatter: nil))
                    && cvvViewModel.validate(.cvv)
        }
    }
    private var keychainService: KeychainServiceProtocol?
    
    // MARK: Constructors
    
    init(model: Card = Card(cardNumber: nil, holdersName: nil, expiryDate: nil, CVV:  nil), keychainService: KeychainServiceProtocol? = KeychainService(key: Card.nameOfClass)) {
        self.card = model
        self.keychainService = keychainService
        setupBind()
    }
    
    // MARK: - Methods
    
    func setupBind() {
        // Define os binds quando os text fields recebem um texto novo de entrada
        cardNumberViewModel.text.bind { [weak self] text in
            // Determina se o texto esta dentro da contagem necessaria para que o campo esteja validado para prosseguir
            self?.cardNumberViewModel.calculateMinimumCountValid(text: text)
            
            // Atribui a model o texto digitado na tela. Se existir, remove a mascara.
            var formattedText = text
            if let mask = self?.cardNumberViewModel.mask, let replacement = self?.cardNumberViewModel.replacement {
                formattedText = text.removeFormatted(mask: mask, replacmentCharacter: Character(replacement))
            }
            self?.card.cardNumber = formattedText
        }
        holdersNameViewModel.text.bind { [weak self] text in
            // Determina se o texto esta dentro da contagem necessaria para que o campo esteja validado para prosseguir
            self?.holdersNameViewModel.calculateMinimumCountValid(text: text)
            
            // Atribui a model o texto digitado na tela. Se existir, remove a mascara.
            var formattedText = text
            if let mask = self?.holdersNameViewModel.mask, let replacement = self?.holdersNameViewModel.replacement {
                formattedText = text.removeFormatted(mask: mask, replacmentCharacter: Character(replacement))
            }
            self?.card.holdersName = formattedText
        }
        expiryDateViewModel.text.bind { [weak self] text in
            // Determina se o texto esta dentro da contagem necessaria para que o campo esteja validado para prosseguir
            self?.expiryDateViewModel.calculateMinimumCountValid(text: text)
            
            // Atribui a model o texto digitado na tela. Se existir, remove a mascara.
            var formattedText = text
            if let mask = self?.expiryDateViewModel.mask, let replacement = self?.expiryDateViewModel.replacement {
                formattedText = text.removeFormatted(mask: mask, replacmentCharacter: Character(replacement))
            }
            self?.card.expiryDate = formattedText
        }
        cvvViewModel.text.bind { [weak self] text in
            // Determina se o texto esta dentro da contagem necessaria para que o campo esteja validado para prosseguir
            self?.cvvViewModel.calculateMinimumCountValid(text: text)
            
            // Atribui a model o texto digitado na tela. Se existir, remove a mascara.
            var formattedText = text
            if let mask = self?.cvvViewModel.mask, let replacement = self?.cvvViewModel.replacement {
                formattedText = text.removeFormatted(mask: mask, replacmentCharacter: Character(replacement))
            }
            self?.card.CVV = Int(formattedText)
        }
        
        // Binds de quando as propriedades de validação de contagem minima e maxima sao redefinidas. Nos atualizamos as mensagens de erro de cada um dos text fields, de volta para a controller
        cardNumberViewModel.isCounted.bind { [weak self] _ in self?.updateCountedAndErrorMessage(self?.cardNumberViewModel) }
        holdersNameViewModel.isCounted.bind { [weak self] _ in self?.updateCountedAndErrorMessage(self?.holdersNameViewModel) }
        expiryDateViewModel.isCounted.bind { [weak self] _ in self?.updateCountedAndErrorMessage(self?.expiryDateViewModel) }
        cvvViewModel.isCounted.bind { [weak self] _ in self?.updateCountedAndErrorMessage(self?.cvvViewModel) }
        
        // Model -> ViewModel
        cardNumberViewModel.text.value = card.cardNumber ?? ""
        holdersNameViewModel.text.value = card.holdersName ?? ""
        expiryDateViewModel.text.value = card.expiryDate ?? ""
        if let cvv = card.CVV { cvvViewModel.text.value = String(cvv) }
    }
    
    func updateCountedAndErrorMessage(_ viewModel: TextFieldViewModel?) {
        // Atualiza o contador geral informando se todos os campos já foram digitados até a sua quantidade minima
        isCounted.value = cardNumberViewModel.isCounted.value
                            && holdersNameViewModel.isCounted.value
                            && expiryDateViewModel.isCounted.value
                            && cvvViewModel.isCounted.value
        
        // Remove a mensagem de erro
        viewModel?.errorMessage.value = nil
    }
    
    /*
     Executa o insert do card no keychain e,
     caso tenha dado certo, envia para o coordinator que finalizamos este modulo
     */
    func saveCard() -> Bool {
        var saveSuccess = false
        
        if isValid {
            // Executa o salvamento
            saveSuccess = keychainService?.save(card) == true
            
            // Caso tenha dado erro, atribui uma mensagem de alerta para exibir na tela
            alertMessage.value = saveSuccess ? "" : "internalError".localizable
        }
        
        return saveSuccess
    }
    
    /*
     Retorna um descritivo que contém a bandeira do cartão e os últimos 4 números
     */
    func cardDescription() -> String {
        guard let cardNumber = card.cardNumber else { return "" }
        let indexLastFourNumbersStart = cardNumber.index(cardNumber.endIndex, offsetBy: -4)
        let indexLastFourNumbersEnd = cardNumber.index(cardNumber.endIndex, offsetBy: 0)
        let lastFourNumbers = String(cardNumber[indexLastFourNumbersStart..<indexLastFourNumbersEnd])
        
        // TODO: Para viés de testes, como utilizaremos 1111111111111111 como único número de cartão válido, então não estamos aplicando a validação que nos diz qual a bandeira, pois acabaria não encontrando uma bandeira para prosseguir no teste. Portanto, foi definido um valor estático.
        return "Mastercard \(lastFourNumbers) •"
    }
    
    
}
