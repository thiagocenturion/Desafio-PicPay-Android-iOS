//
//  CardRegisterViewModelTest.swift
//  Desafio-PicPay-Android-iOSTests
//
//  Created by Avanade on 06/06/19.
//  Copyright © 2019 ThiagoCenturion. All rights reserved.
//

import XCTest
@testable import Desafio_PicPay_Android_iOS

class CardRegisterViewModelTest: XCTestCase {
    var sut: CardRegisterViewModel! = nil

    override func setUp() {
        sut = CardRegisterViewModel()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testCardNumberCounted() {
        let incompletedText = "1111 1111 1111" // 12 caracteres
        let correctText = "1111 1111 1111 1234" // 13 caracteres
        
        // Para texto invalido, a view model deve retornar falso quando se diz que ele esta no minimo de contagem necessaria
        sut.cardNumberViewModel.text.value = incompletedText
        XCTAssertFalse(sut.cardNumberViewModel.isCounted.value)
        XCTAssertFalse(sut.cardNumberViewModel.validate(.creditCard))
        
        // Quando o texto estiver acima do minimo, ou seja 13 ou mais digitos, entao ele deverá retornar true
        sut.cardNumberViewModel.text.value = correctText
        XCTAssertTrue(sut.cardNumberViewModel.isCounted.value)
        XCTAssertTrue(sut.cardNumberViewModel.validate(.creditCard))
    }
    
    func testHoldersNameValidated() {
        let emptyName = ""
        let name = "Nome Sobrenome Completo"
        
        // Para nome vazio, deve ser falso
        sut.holdersNameViewModel.text.value = emptyName
        XCTAssertFalse(sut.holdersNameViewModel.isCounted.value)
        XCTAssertFalse(sut.holdersNameViewModel.validate(.name))
        
        // Para nome preenchido
        sut.holdersNameViewModel.text.value = name
        XCTAssertTrue(sut.holdersNameViewModel.isCounted.value)
        XCTAssertTrue(sut.holdersNameViewModel.validate(.name))
    }
    
    func testExpiryDateValidated() {
        let formatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "MM/yy"
            return formatter
        }()
        let invalidDate = "13/18"
        let addingMonthDate = Calendar.current.date(byAdding: .month, value: 1, to: Date()) ?? Date()
        let validDate = formatter.string(from: addingMonthDate)
        
        // Data inválida, deve ser true para contagem minima mas false para validação
        sut.expiryDateViewModel.text.value = invalidDate
        XCTAssertTrue(sut.expiryDateViewModel.isCounted.value)
        XCTAssertFalse(sut.expiryDateViewModel.validate( .expiryDate(formatter: formatter) ))
        
        // Data válida, deve ser tudo válido
        sut.expiryDateViewModel.text.value = validDate
        XCTAssertTrue(sut.expiryDateViewModel.isCounted.value)
        XCTAssertTrue(sut.expiryDateViewModel.validate( .expiryDate(formatter: formatter) ))
    }
    
    func testCvvValidated() {
        let invalidCvv = "12"
        let validCvv = "123"
        
        // Para CVV vazio, nao deve ter nem validação e nem preenchimento ok
        sut.cvvViewModel.text.value = ""
        XCTAssertFalse(sut.cvvViewModel.isCounted.value)
        XCTAssertFalse(sut.cvvViewModel.validate(.cvv))
        
        // Para CVV inválido, deve ter validacao falsa, mas preenchimento ok
        sut.cvvViewModel.text.value = invalidCvv
        XCTAssertTrue(sut.cvvViewModel.isCounted.value)
        XCTAssertFalse(sut.cvvViewModel.validate(.cvv))
        
        // CVV válido, 3 digitos conforme esperado
        sut.cvvViewModel.text.value = validCvv
        XCTAssertTrue(sut.cvvViewModel.isCounted.value)
        XCTAssertTrue(sut.cvvViewModel.validate(.cvv))
    }
    
    func testCardRetriveSuccess() {
        let card = Card(cardNumber: "1234567812345678", holdersName: "Nome Completo", expiryDate: "01/18", CVV: 123)
        let key = "CreditCardTest"
        
        if KeychainService.save(card, for: key) {
            // O cartao de credito recuperado do keychain deve ser o mesmo utilizado para armazenar
            let retrivedCard = KeychainService.retriveCard(for: key)
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
        let key = "CreditCardTest"
        
        if KeychainService.save(card, for: key) {
            // Caso obteve o cartao de credito, significa que salvou com sucesso
            if let _ = KeychainService.retriveCard(for: key) {
                // Remove o cartao da memoria
                let isRemoved = KeychainService.removeCard(for: key)
                XCTAssertTrue(isRemoved)
            } else {
                XCTFail("Problema em obter o cartao de credito")
            }
        } else {
            XCTFail("Problema em salvar o cartao de credito")
        }
    }

}
