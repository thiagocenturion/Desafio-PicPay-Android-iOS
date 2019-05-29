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
    
    var textFieldControllerFloating = MDCTextInputControllerUnderline()
    @IBInspectable dynamic open var characterCountMax: Int = 0 {
        didSet {
            textFieldControllerFloating.characterCountMax = UInt(characterCountMax)
        }
    }
    
    // MARK: - View Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    // MARK: - Methods
    
    func setup() {
        textFieldControllerFloating = MDCTextInputControllerUnderline(textInput: self)
        
        // Colors
        let placeholderColor = Color.placeholder
        tintColor = Color.secondary
        textFieldControllerFloating.inlinePlaceholderColor = placeholderColor
        textFieldControllerFloating.floatingPlaceholderNormalColor = placeholderColor
        textFieldControllerFloating.floatingPlaceholderActiveColor = tintColor
        textFieldControllerFloating.borderFillColor = tintColor
        
        // Font
        textFieldControllerFloating.textInputFont = UIFont.systemFont(ofSize: 16, weight: .regular)
        textFieldControllerFloating.inlinePlaceholderFont = UIFont.systemFont(ofSize: 13, weight: .bold)
    }

}
