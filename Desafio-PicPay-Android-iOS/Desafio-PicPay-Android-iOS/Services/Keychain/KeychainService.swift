//
//  KeychainService.swift
//  Desafio-PicPay-Android-iOS
//
//  Created by Avanade on 28/06/19.
//  Copyright © 2019 ThiagoCenturion. All rights reserved.
//

import Foundation
import SwiftKeychainWrapper

class KeychainService {
    static func save(_ card: Card, for key: String) -> Bool {
        // Converte o cartao de credito para Data
        let cardData = NSKeyedArchiver.archivedData(withRootObject: card)
        
        // Executa o insert no keychain
        let saveSucessful = KeychainWrapper.standard.set(cardData, forKey: key)
        
        return saveSucessful
    }
    
    static func retriveCard(for key: String) -> Card? {
        // Executa o get do keychain
        guard let retrivedCardData = KeychainWrapper.standard.data(forKey: key) else { return nil }
        
        // Converte para objeto
        let retrivedCard = NSKeyedUnarchiver.unarchiveObject(with: retrivedCardData) as? Card
        
        return retrivedCard
    }
    
    static func removeCard(for key: String) -> Bool {
        return KeychainWrapper.standard.removeObject(forKey: key)
    }
}
