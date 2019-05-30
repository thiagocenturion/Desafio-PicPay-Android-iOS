//
//  Card.swift
//  Desafio-PicPay-Android-iOS
//
//  Created by Avanade on 29/05/19.
//  Copyright © 2019 ThiagoCenturion. All rights reserved.
//

import Foundation

/**
 Representacao de um cartao de crédito. E utilizado para cadastrar um cartao novo, editar, armazenar ou resgatar do armazenamento.
 */
struct Card {
    var cardNumber: String?
    var holdersName: String?
    var expiryDate: String?
    var CVV: Int?
}
