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
class Card: NSObject, NSCoding {
    var cardNumber: String?
    var holdersName: String?
    var expiryDate: String?
    var CVV: Int?
    
    init(cardNumber: String?, holdersName: String?, expiryDate: String?, CVV: Int?) {
        self.cardNumber = cardNumber
        self.holdersName = holdersName
        self.expiryDate = expiryDate
        self.CVV = CVV
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let cardNumber = aDecoder.decodeObject(forKey: "cardNumber") as? String
        let holdersName = aDecoder.decodeObject(forKey: "holdersName") as? String
        let expiryDate = aDecoder.decodeObject(forKey: "expiryDate") as? String
        let CVV = aDecoder.decodeInteger(forKey: "CVV")
        
        self.init(cardNumber: cardNumber, holdersName: holdersName, expiryDate: expiryDate, CVV: CVV)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(cardNumber, forKey: "cardNumber")
        aCoder.encode(holdersName, forKey: "holdersName")
        aCoder.encode(expiryDate, forKey: "expiryDate")
        aCoder.encode(CVV ?? 000, forKey: "CVV")
    }
}
