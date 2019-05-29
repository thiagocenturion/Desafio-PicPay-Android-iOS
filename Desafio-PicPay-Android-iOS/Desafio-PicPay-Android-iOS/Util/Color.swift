//
//  Color.swift
//  Desafio-PicPay-Android-iOS
//
//  Created by Avanade on 17/05/19.
//  Copyright © 2019 ThiagoCenturion. All rights reserved.
//

import UIKit

class Color: UIColor {
    open class var primary: UIColor { return Color.white }
    open class var secondary: UIColor { return Color(red: 0.07, green: 0.78, blue: 0.44, alpha: 1) }
    open class var third: UIColor { return Color(red: 0.67, green: 0.69, blue: 0.74, alpha: 1) }
    open class var fourth: UIColor { return Color(red: 0.17, green: 0.17, blue: 0.18, alpha: 1) }
    open class var primaryVariant: UIColor { return Color(red: 1, green: 1, blue: 1, alpha: 0.8) }
    open class var primaryBackground: UIColor { return Color(red: 0.11, green: 0.12, blue: 0.13, alpha: 1) }
    open class var disabledBackground: UIColor { return Color(red: 0.56, green: 0.57, blue: 0.62, alpha: 1) }
    open class var placeholder: UIColor { return Color(red: 1, green: 1, blue: 1, alpha: 0.4) }
}
