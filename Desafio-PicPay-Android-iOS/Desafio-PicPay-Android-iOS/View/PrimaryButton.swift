//
//  PrimaryButton.swift
//  Desafio-PicPay-Android-iOS
//
//  Created by Avanade on 29/05/19.
//  Copyright © 2019 ThiagoCenturion. All rights reserved.
//

import UIKit

@IBDesignable
class PrimaryButton: UIButton {
    
    // MARK: - Constructors
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
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
    
    func setup() {
        titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        titleLabel?.textAlignment = .center
        updateColors()
    }
    
    func updateColors() {
        // Atualiza as cores do botao de acordo com o seu estado
        backgroundColor = isEnabled ? Color.second : Color.disabledBackground
        tintColor = Color.primary
        setTitleColor(Color.primary, for: .normal)
        setTitleColor(Color.primary, for: .disabled)
    }

}
