//
//  Payment.swift
//  Desafio-PicPay-Android-iOS
//
//  Created by Avanade on 29/05/19.
//  Copyright © 2019 ThiagoCenturion. All rights reserved.
//

import Foundation

/**
 Model utilizada para serializar para JSON e enviar um POST para http://careers.picpay.com/tests/mobdev/transaction.
 O JSON deve obedecer a seguinte estrutura:
 {
 "card_number":"1111111111111111",
 "cvv":789,
 "value":79.9,
 "expiry_date":"01/18",
 "destination_user_id":1002
 }
 */
struct Payment: Codable {
    let cardNumber: String
    let cvv: Int
    let value: Float
    let expiryDate: String
    let destinationUserId: Int
    
    private enum CodingKeys: String, CodingKey {
        case cardNumber = "card_number"
        case cvv = "cvv"
        case value = "value"
        case expiryDate = "expiry_date"
        case destinationUserId = "destination_user_id"
    }
}
