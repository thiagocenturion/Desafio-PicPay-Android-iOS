//
//  PrimaryButton.swift
//  Desafio-PicPay-Android-iOS
//
//  Created by Avanade on 29/05/19.
//  Copyright © 2019 ThiagoCenturion. All rights reserved.
//

import UIKit

@IBDesignable
class PrimaryButton: KeyboardMovingButton {
    
    override var isEnabled: Bool {
        didSet {
            updateColors()
        }
    }
    
    // MARK: - View Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = bounds.height / 2
        clipsToBounds = true
    }
    
    // MARK: - Methods
    
    override func setup() {
        super.setup()
        titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        titleLabel?.textAlignment = .center
        updateColors()
    }
    
    func updateColors() {
        // Atualiza as cores do botao de acordo com o seu estado
        backgroundColor = isEnabled ? Color.secondary : Color.disabledBackground
        tintColor = Color.primary
        setTitleColor(Color.primary, for: .normal)
        setTitleColor(Color.primary, for: .disabled)
    }

}
