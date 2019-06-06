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
    
    private(set) var cardNumberViewModel = TextFieldViewModel(mask: "#### #### #### ####", replacement: "#")
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
        cardNumberViewModel.text.bind { [weak self] text in
            self?.cardNumberViewModel.isCounted.value = self?.calculateMinimumCountValid(text: text, mask: self?.cardNumberViewModel.mask) ?? false
        }
        holdersNameViewModel.text.bind { [weak self] text in
            self?.holdersNameViewModel.isCounted.value = self?.calculateMinimumCountValid(text: text, mask: self?.holdersNameViewModel.mask) ?? false
        }
        expiryDateViewModel.text.bind { [weak self] text in
            self?.expiryDateViewModel.isCounted.value = self?.calculateMinimumCountValid(text: text, mask: self?.expiryDateViewModel.mask) ?? false
        }
        cvvViewModel.text.bind { [weak self] text in
            self?.cvvViewModel.isCounted.value = self?.calculateMinimumCountValid(text: text, mask: self?.cvvViewModel.mask) ?? false
        }
        
        cardNumberViewModel.isCounted.bind { [weak self] _ in self?.updateCountedAndErrorMessage(self?.cardNumberViewModel) }
        holdersNameViewModel.isCounted.bind { [weak self] _ in self?.updateCountedAndErrorMessage(self?.holdersNameViewModel) }
        expiryDateViewModel.isCounted.bind { [weak self] _ in self?.updateCountedAndErrorMessage(self?.expiryDateViewModel) }
        cvvViewModel.isCounted.bind { [weak self] _ in self?.updateCountedAndErrorMessage(self?.cvvViewModel) }
    }
    
    func calculateMinimumCountValid(text: String, mask: String?) -> Bool {
        // Caso tenha mascara, o texto de entrada tem que ter exatamente o mesmo tamanho da mascara para ser valido
        if let mask = mask {
            return text.count == mask.count
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
