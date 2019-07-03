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
        let removedMaskValue = value.removeFormatted(mask: "#### #### #### #### ###", replacmentCharacter: "#")
        guard removedMaskValue.count >= 13 && removedMaskValue.count <= 19 else {
            throw ValidatorError("creditCardCountError".localizable)
        }
        
        return value
    }
}

struct NameValidator: ValidatorProtocol {
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
    func validated(_ value: String) throws -> String {
        guard value.count == 3 else {
            throw ValidatorError("cvvValidator".localizable)
        }
        
        return value
    }
}
