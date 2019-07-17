//
//  TextFieldViewModel.swift
//  Desafio-PicPay-Android-iOS
//
//  Created by Avanade on 06/06/19.
//  Copyright © 2019 ThiagoCenturion. All rights reserved.
//

import Foundation

class TextFieldViewModel: NSObject {
    var text = Dynamic("")
    var isCounted = Dynamic(false)
    var errorMessage: Dynamic<String?> = Dynamic("")
    private(set) var mask: String?
    private(set) var replacement: String?
    private(set) var minimumCount: Int?
    
    init(mask: String? = nil, replacement: String? = nil, minimumCount: Int? = nil) {
        super.init()
        self.mask = mask
        self.replacement = replacement
        self.minimumCount = minimumCount
    }
    
    func validate(_ validationType: ValidatorType) -> Bool {
        do {
            // Realiza as validacoes desse text field. Caso não tenha caido no catch, significa que validou corretamente, entao retorna true
            let validator = Validator.validator(for: validationType)
            let _ = try validator.validated(text.value)
            return true
        } catch(let error) {
            if let error = error as? ValidatorError {
                errorMessage.value = error.message
            }
        }
        
        // So retornara false quando cair no catch de erro
        return false
    }
    
    func calculateMinimumCountValid(text: String) {
        var isCalculatedCount = false
        
        if let mask = mask {
            // Caso tenha mascara, verifica se temos contador minimo. Se sim, remove a mascara e verifica se o texto possui a contagem minima depois disso.
            if let minimumCount = minimumCount, let replacement = replacement {
                isCalculatedCount = text.removeFormatted(mask: mask, replacmentCharacter: Character(replacement)).count >= minimumCount
            } else {
                // Se não tem contador minimo, o texto tem que ser exatamente igual ao tamanho maximo de sua máscara
                isCalculatedCount = text.count == mask.count
            }
        } else if let minimumCount = minimumCount {
            isCalculatedCount = text.count >= minimumCount
        } else {
            // Quando nao possui mascara, apenas deve existir texto escrito
            isCalculatedCount = text.count > 0
        }
        
        isCounted.value = isCalculatedCount
    }
}
