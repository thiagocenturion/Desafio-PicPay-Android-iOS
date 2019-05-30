//
//  DefaultTextField.swift
//  Desafio-PicPay-Android-iOS
//
//  Created by Avanade on 29/05/19.
//  Copyright © 2019 ThiagoCenturion. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialTextFields

@IBDesignable
class DefaultTextField: MDCTextField {

    @IBInspectable dynamic open var characterCountMax: UInt = 0
    @IBInspectable dynamic open var maskPattern: String = ""
    var textFieldControllerFloating = MDCTextInputControllerUnderline()
    var replacmentCharacter: Character = "#"
    
    // MARK: - View Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    // MARK: - Methods
    
    func setup() {
        delegate = self
        
        textFieldControllerFloating = MDCTextInputControllerUnderline(textInput: self)
        
        // Colors
        let placeholderColor = Color.placeholder
        tintColor = Color.secondary
        textColor = Color.primary
        textFieldControllerFloating.inlinePlaceholderColor = placeholderColor
        textFieldControllerFloating.floatingPlaceholderNormalColor = placeholderColor
        textFieldControllerFloating.floatingPlaceholderActiveColor = tintColor
        textFieldControllerFloating.activeColor = tintColor
        textFieldControllerFloating.characterCountMax = characterCountMax
        
        // Remove o botão de limpeza de texto e de máximo de caracteres
        clearButtonMode = .never
        trailingUnderlineLabel.isHidden = true
    }

}

extension DefaultTextField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Converte para o Range que é utilizado no método de substituicao de String
        guard let rangeExpression = Range(range, in: textField.text ?? "") else { return true }
        
        // Obtem a nova string
        guard let newString = textField.text?.replacingCharacters(in: rangeExpression, with: string) else { return true }
        
        // Caso não tenhamos nenhuma mascara definida, entao pode prosseguir normalmente
        if maskPattern.isEmpty {
            // Somente se estiver dentro do limite de caracteres disponivel
            return newString.count <= Int(characterCountMax)
        } else {
            // Se o resultado for maior que o limite de caracteres disponivel, retorna a string anterior. Senao, realiza a formatacao com base na mascara definida
            textField.text = newString.count > Int(characterCountMax) ? textField.text : newString.formatted(mask: maskPattern, replacmentCharacter: replacmentCharacter)
            
            // Sempre retorna falso pois estamos adicionando o texto manualmente
            return false
        }
    }
}
