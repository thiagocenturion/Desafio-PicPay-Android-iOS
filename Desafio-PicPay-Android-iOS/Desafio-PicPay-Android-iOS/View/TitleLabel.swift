//
//  TitleLabel.swift
//  Desafio-PicPay-Android-iOS
//
//  Created by Avanade on 29/05/19.
//  Copyright © 2019 ThiagoCenturion. All rights reserved.
//

import UIKit

class TitleLabel: UILabel {
    
    let paragraphStyle: NSMutableParagraphStyle = {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 0
        return paragraphStyle
    }()
    override var text: String? {
        didSet {
            updateParagraph(text)
        }
    }
    
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
        font = UIFont.boldSystemFont(ofSize: 28)
        textColor = Color.primary
        numberOfLines = 0
        lineBreakMode = .byWordWrapping
        textAlignment = .center
        updateParagraph(text)
    }
    
    func updateParagraph(_ newText: String?) {
        attributedText = NSMutableAttributedString(string: newText ?? "", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }
}
