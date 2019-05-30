//
//  DescriptionLabel.swift
//  Desafio-PicPay-Android-iOS
//
//  Created by Avanade on 29/05/19.
//  Copyright © 2019 ThiagoCenturion. All rights reserved.
//

import UIKit

class DescriptionLabel: UILabel {
    
    // MARK: - Constructors
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    // MARK: - Methods
    
    func setup() {
        font = UIFont.systemFont(ofSize: 14)
        textColor = Color.primaryVariant
        numberOfLines = 0
        lineBreakMode = .byWordWrapping
        textAlignment = .center
    }

}
