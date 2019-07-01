//
//  KeychainService.swift
//  Desafio-PicPay-Android-iOS
//
//  Created by Avanade on 28/06/19.
//  Copyright © 2019 ThiagoCenturion. All rights reserved.
//

import Foundation
import SwiftKeychainWrapper

protocol KeychainServiceProtocol {
    var key: String { get }
    init(key: String)
    func save<T>(_ object: T) -> Bool
    func retriveObject<T>() -> T?
    func remove() -> Bool
}

class KeychainService: KeychainServiceProtocol {
    var key: String
    
    required init(key: String) {
        self.key = key
    }
    
    func save<T>(_ object: T) -> Bool {
        // Converte o objeto para Data
        let objectData = NSKeyedArchiver.archivedData(withRootObject: object)
        
        // Executa o insert no keychain
        let saveSucessful = KeychainWrapper.standard.set(objectData, forKey: key)
        
        return saveSucessful
    }
    
    func retriveObject<T>() -> T? {
        // Executa o get do keychain
        guard let retrivedData = KeychainWrapper.standard.data(forKey: key) else { return nil }
        
        // Converte para objeto
        let retrivedObject = NSKeyedUnarchiver.unarchiveObject(with: retrivedData) as? T
        
        return retrivedObject
    }
    
    func remove() -> Bool {
        return KeychainWrapper.standard.removeObject(forKey: key)
    }
}
