//
//  KeychainServiceTests.swift
//  Desafio-PicPay-Android-iOSTests
//
//  Created by Avanade on 30/06/19.
//  Copyright © 2019 ThiagoCenturion. All rights reserved.
//

import XCTest
@testable import Desafio_PicPay_Android_iOS

class KeychainServiceTests: XCTestCase {
    var sut: KeychainServiceProtocol?
    
    override func setUp() {
        sut = KeychainService(key: "KeychainServiceTests")
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testCardRetriveSuccess() {
        let card = Card(cardNumber: "1234567812345678", holdersName: "Nome Completo", expiryDate: "01/18", CVV: 123)
        
        if sut?.save(card) == true {
            // O cartao de credito recuperado do keychain deve ser o mesmo utilizado para armazenar
            let retrivedCard = sut?.retriveObject() as Card?
            XCTAssertEqual(retrivedCard?.cardNumber?.description, card.cardNumber?.description)
            XCTAssertEqual(retrivedCard?.holdersName?.description, card.holdersName?.description)
            XCTAssertEqual(retrivedCard?.expiryDate?.description, card.expiryDate?.description)
            XCTAssertEqual(retrivedCard?.CVV, card.CVV)
        } else {
            XCTFail("Problema em salvar o cartao de credito")
        }
    }
    
    func testCardRetriveFailure() {
        let card = Card(cardNumber: "1234567812345678", holdersName: "Nome Completo", expiryDate: "01/18", CVV: 123)
        
        if sut?.save(card) == true {
            // Caso obteve o cartao de credito, significa que salvou com sucesso
            if let _ = sut?.retriveObject() as Card? {
                // Remove o cartao da memoria
                let isRemoved = (sut?.remove() == true)
                XCTAssertTrue(isRemoved)
            } else {
                XCTFail("Problema em obter o cartao de credito")
            }
        } else {
            XCTFail("Problema em salvar o cartao de credito")
        }
    }
}

class MockKeychainService: KeychainServiceProtocol {
    var isSavedCard = true
    var isRetrivedCard: Card?
    var isRemovedCard = true
    var key: String
    
    required init(key: String) {
        self.key = key
    }
    
    func save<T>(_ object: T) -> Bool {
        return isSavedCard
    }
    
    func retriveObject<T>() -> T? {
        return isRetrivedCard as? T
    }
    
    func remove() -> Bool {
        return isRemovedCard
    }
}
