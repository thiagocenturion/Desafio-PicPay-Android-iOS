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
    
    var cardNumber: String?
    var holdersName: String?
    var expiryDate: Date?
    var CVV: Int?
    let card: Card = Card(cardNumber: nil, holdersName: nil, expiryDate: nil, CVV:  nil)
    var isLoading: Dynamic<Bool> = Dynamic(false)
    var alertMessage: Dynamic<String> = Dynamic("")
    
    // MARK: Constructors
    
//    init(sqlRepository: SqlRepository? = SqlRepositoryCard()) {
//        self.sqlRepository = sqlRepository
//        super.init()
//    }
    
    // MARK: - Methods
    
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
