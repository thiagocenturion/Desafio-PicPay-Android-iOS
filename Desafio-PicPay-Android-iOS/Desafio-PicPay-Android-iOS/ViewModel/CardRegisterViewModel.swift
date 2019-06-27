//
//  CardPrimingViewModel.swift
//  Desafio-PicPay-Android-iOS
//
//  Created by Avanade on 30/05/19.
//  Copyright © 2019 ThiagoCenturion. All rights reserved.
//

import Foundation

class CardRegisterViewModel: NSObject {
    
    // MARK: - Properties
    
    private(set) var cardNumberViewModel = TextFieldViewModel(mask: "#### #### #### #### ###", replacement: "#", minimumCount: 13)
    private(set) var holdersNameViewModel = TextFieldViewModel()
    private(set) var expiryDateViewModel = TextFieldViewModel(mask: "##/##", replacement: "#")
    private(set) var cvvViewModel = TextFieldViewModel()
    private(set) var card: Card = Card(cardNumber: nil, holdersName: nil, expiryDate: nil, CVV:  nil)
    var isLoading = Dynamic(false)
    var isCounted = Dynamic(false)
    var alertMessage = Dynamic("")
    var isValid: Bool {
        get {
            return cardNumberViewModel.validate(.creditCard)
                    && holdersNameViewModel.validate(.name)
                    && expiryDateViewModel.validate(.expiryDate(formatter: nil))
                    && cvvViewModel.validate(.cvv)
        }
    }
    
    // MARK: Constructors
    
//    init(sqlRepository: SqlRepository? = SqlRepositoryCard()) {
//        self.sqlRepository = sqlRepository
//        super.init()
//    }
    
    override init() {
        super.init()
        setupBind()
    }
    
    // MARK: - Methods
    
    func setupBind() {
        // Define os binds quando os text fields recebem um texto novo de entrada
        cardNumberViewModel.text.bind { [weak self] text in
            self?.cardNumberViewModel.isCounted.value = self?.calculateMinimumCountValid(text: text, with: self?.cardNumberViewModel) ?? false
        }
        holdersNameViewModel.text.bind { [weak self] text in
            self?.holdersNameViewModel.isCounted.value = self?.calculateMinimumCountValid(text: text, with: self?.holdersNameViewModel) ?? false
        }
        expiryDateViewModel.text.bind { [weak self] text in
            self?.expiryDateViewModel.isCounted.value = self?.calculateMinimumCountValid(text: text, with: self?.expiryDateViewModel) ?? false
        }
        cvvViewModel.text.bind { [weak self] text in
            self?.cvvViewModel.isCounted.value = self?.calculateMinimumCountValid(text: text, with: self?.cvvViewModel) ?? false
        }
        
        // Binds de quando as propriedades de validação de contagem minima e maxima sao redefinidas. Nos atualizamos as mensagens de erro de cada um dos text fields, de volta para a controller
        cardNumberViewModel.isCounted.bind { [weak self] _ in self?.updateCountedAndErrorMessage(self?.cardNumberViewModel) }
        holdersNameViewModel.isCounted.bind { [weak self] _ in self?.updateCountedAndErrorMessage(self?.holdersNameViewModel) }
        expiryDateViewModel.isCounted.bind { [weak self] _ in self?.updateCountedAndErrorMessage(self?.expiryDateViewModel) }
        cvvViewModel.isCounted.bind { [weak self] _ in self?.updateCountedAndErrorMessage(self?.cvvViewModel) }
    }
    
    func calculateMinimumCountValid(text: String, with txtViewModel: TextFieldViewModel?) -> Bool {
        if let mask = txtViewModel?.mask {
            // Caso tenha mascara, verifica se temos contador minimo. Se sim, remove a mascara e verifica se o texto possui a contagem minima depois disso.
            if let minimumCount = txtViewModel?.minimumCount, let replacement = txtViewModel?.replacement {
                return text.removeFormatted(mask: mask, replacmentCharacter: Character(replacement)).count >= minimumCount
            } else {
                // Se não tem contador minimo, o texto tem que ser exatamente igual ao tamanho maximo de sua máscara
                return text.count == mask.count
            }
        } else if let minimumCount = txtViewModel?.minimumCount {
            return text.count >= minimumCount
        } else {
            // Quando nao possui mascara, apenas deve existir texto escrito
            return text.count > 0
        }
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
    
    func saveCard() {
//        isLoading.value = true
//        networkRequest?.request(with: { [weak self] (contacts: [Contact]?, error: APIError?) in
//            self?.isLoading.value = false
//            if let error = error {
//                self?.alertMessage.value = error.rawValue.localizable
//            } else if let contacts = contacts {
//                self?.arrAllContactViewModels = self?.createCellViewModels(contacts: contacts) ?? [ContactViewModel]()
//            } else {
//                self?.alertMessage.value = APIError.internalError.rawValue.localizable
//            }
//        })
    }
}
