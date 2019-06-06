//
//  Validation.swift
//  Desafio-PicPay-Android-iOS
//
//  Created by Avanade on 02/06/19.
//  Copyright © 2019 ThiagoCenturion. All rights reserved.
//

import Foundation

class ValidatorError: Error {
    var message: String
    
    init(_ message: String) {
        self.message = message
    }
}

protocol ValidatorProtocol {
    func validated(_ value: String) throws -> String
}

enum ValidatorType {
    typealias MaskReplacmentCharacterAlias = (String, Character)
    case creditCard
    case name
    case expiryDate(formatter: DateFormatter?)
    case cvv
}

enum Validator {
    static func validator(for type: ValidatorType) -> ValidatorProtocol {
        switch type {
        case .creditCard: return CreditCardValidator()
        case .name: return NameValidator()
        case .expiryDate(let formatter):
            if let formatter = formatter {
                return ExpiryDateValidator(formatter)
            } else {
                return ExpiryDateValidator()
            }
        case .cvv: return CvvValidator()
        }
    }
}

struct CreditCardValidator: ValidatorProtocol {
    func validated(_ value: String) throws -> String {
        
        // TODO: 1 - Testar com menos de 16 digitos
        guard value.removeFormatted(mask: "#### #### #### ####", replacmentCharacter: "#").count == 16 else {
            throw ValidatorError("creditCardCountError".localizable)
        }
        
        return value
    }
}

struct NameValidator: ValidatorProtocol {
    // TODO: 1 - Testar com nome maior que 50 digitos
    // TODO: 2 - Testar com nome sem sobrenome
    func validated(_ value: String) throws -> String {
        guard value.count <= 50 else {
            throw ValidatorError("nameCountValidator".localizable)
        }
        
        guard value.split(separator: " ").count > 1 else {
            throw ValidatorError("nameFullnameValidator".localizable)
        }
        
        return value
    }
}

struct ExpiryDateValidator: ValidatorProtocol {
    private var formatter: DateFormatter
    
    init( _ formatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "MM/yy"
            return formatter
        }() ) {
        self.formatter = formatter
    }
    
    // TODO: 1 - testar com data maior que 12 meses: 13/27
    // TODO: 2 - testar com data retroativa: 05/18
    // TODO: 3 - testar com data igual: 06/19
    // TODO: 4 - testar com data acima: 09/27
    func validated(_ value: String) throws -> String {
        guard value.count == 5 else {
            throw ValidatorError("expiryDateInvalidValidator".localizable)
        }
        
        // Essa operacao realiza a comparacao sem considerar o tempo hh:mm:ss e o dia (somente mes e ano)
        let dateComponent = Calendar.current.dateComponents([.month, .year], from: Date())
        let dateToday = Calendar.current.date(from: dateComponent)
        
        // Verifica se a data de hoje e maior que a data digitada
        if let date = formatter.date(from: value) {
            if dateToday?.compare(date) == .orderedDescending {
                throw ValidatorError("expiryDateInvalidValidator".localizable)
            }
        } else {
            throw ValidatorError("expiryDateInvalidValidator".localizable)
        }
        
        return value
    }
}

struct CvvValidator: ValidatorProtocol {
    // TODO: 1 - Testar com código de CVV incompleto: 12
    func validated(_ value: String) throws -> String {
        guard value.count == 3 else {
            throw ValidatorError("cvvValidator".localizable)
        }
        
        return value
    }
}
