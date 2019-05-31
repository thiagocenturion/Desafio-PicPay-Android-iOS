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

    @IBInspectable dynamic open var limitLength: UInt = 0
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
        addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
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
        
        // Remove o botão de limpeza de texto e de máximo de caracteres
        clearButtonMode = .never
        trailingUnderlineLabel.isHidden = true
    }
    
    @objc func textFieldDidChange(textField: UITextField) {
        applyFilter(textField: textField)
    }
    
    func applyFilter(textField: UITextField) {
        // Só realiza o filtro se tivermos alguma mascara definida, senao ele ira travar o texto
        guard !maskPattern.isEmpty else { return }
        
        // Realiza a formatacao com base na mascara definida
        textField.text = textField.text?.formatted(mask: maskPattern, replacmentCharacter: replacmentCharacter)
    }

}

extension DefaultTextField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let rangeExpression = Range(range, in: textField.text ?? "") else { return true }
        guard var newString = textField.text?.replacingCharacters(in: rangeExpression, with: string) else { return true }
        guard limitLength > 0 else { return true }
        
        // Remove qualquer tipo de máscara para evitar que a contagem dos caracteres seja errada.
        newString = newString.removeFormatted(mask: maskPattern, replacmentCharacter: replacmentCharacter)
        
        // Somente se estiver dentro do limite de caracteres disponivel
        return newString.count <= Int(limitLength)
    }
}
