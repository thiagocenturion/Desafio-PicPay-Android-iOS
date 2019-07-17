//
//  ValidatorTest.swift
//  Desafio-PicPay-Android-iOSTests
//
//  Created by Avanade on 07/06/19.
//  Copyright © 2019 ThiagoCenturion. All rights reserved.
//

import XCTest
@testable import Desafio_PicPay_Android_iOS

class ValidatorTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testCardNumberValidator() {
        let validator = CreditCardValidator()
        
        // Para texto incompleto (menos de 13 caracteres), o validator não deve retornar o texto
        let invalidCardNumber = try? validator.validated("1234 1234 1234") // 12 caracteres
        XCTAssertNil(invalidCardNumber)
        
        // Para texto grande (mais de 19 caracteres), o validator não deve retornar o texto
        let tooLongCardNumber = try? validator.validated("1234 1234 1234 1234 1234") // 20 caracteres
        XCTAssertNil(tooLongCardNumber)
        
        // Quando o texto estiver completo, ou seja 13 a 19 digitos, entao ele deverá retornar o mesmo texto que entrou
        let validCardNumber = "1234 1234 1234 1234"
        let validCardNumberValidated = try? validator.validated(validCardNumber)
        XCTAssertEqual(validCardNumber, validCardNumberValidated)
    }
    
    func testHoldersNameValidator() {
        let validator = NameValidator()
        
        // Teste com nome maior que 50 digitos (valor estipulado para teste)
        let tooLongName = try? validator.validated("Isabel Cristina Leopoldina Augusta Michaela Gabriela Raphaela Gonzaga de Bragança e Bourbon")
        XCTAssertNil(tooLongName)
        
        // Teste com nome sem sobrenome
        let singleName = try? validator.validated("Isabel")
        XCTAssertNil(singleName)
        
        // Sucesso para nome com sobrenome e menos de 50 dígitos
        let validName = "Isabel C B Bourbon"
        let validNameValidated = try? validator.validated(validName)
        XCTAssertEqual(validNameValidated, validName)
    }
    
    func testExpiryDateValidator() {
        let formatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "MM/yy"
            return formatter
        }()
        let validator = ExpiryDateValidator(formatter)
        
        // Teste com data maior que 12 meses: 13/27
        let missingMonth = try? validator.validated("13/27")
        XCTAssertNil(missingMonth)
        
        // Teste com data retroativa: 05/18
        let oldDate = try? validator.validated("05/18")
        XCTAssertNil(oldDate)
        
        // Teste com data igual a atual
        let todayDate = formatter.string(from: Date())
        let equalTodayDateValidated = try? validator.validated(todayDate)
        XCTAssertEqual(todayDate, equalTodayDateValidated)
        
        // Teste com data futura (adiciona-se 1 mes à data atual)
        if let newDate = Calendar.current.date(byAdding: .month, value: 1, to: Date()) {
            let futureDate = formatter.string(from: newDate)
            let futureDateValidated = try? validator.validated(futureDate)
            XCTAssertEqual(futureDate, futureDateValidated)
        }
    }
    
    func testCvvValidator() {
        let validator = CvvValidator()
        
        // Teste com código de CVV incompleto: 12
        let invalidCvv = try? validator.validated("12")
        XCTAssertNil(invalidCvv)
    }

}
