//
//  Extension.swift
//  Desafio-PicPay-Android-iOS
//
//  Created by Avanade on 17/05/19.
//  Copyright © 2019 ThiagoCenturion. All rights reserved.
//

import UIKit

extension String {
    var localizable: String {
        return NSLocalizedString(self, comment: "")
    }
}

extension NSObject {
    public static var nameOfClass: String {
        return String(describing: self).components(separatedBy: ".").last!
    }
}

extension UIImage {
    class func image(with color: UIColor, size: CGSize) -> UIImage? {
        let image: UIImage?
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(rect)
        image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    class func rounded(image: UIImage?, cornerRadius: CGFloat) -> UIImage? {
        let rect = CGRect(origin:CGPoint(x: 0, y: 0), size: image?.size ?? CGSize.zero)
        UIGraphicsBeginImageContextWithOptions(image?.size ?? CGSize.zero, false, 1)
        UIBezierPath(
            roundedRect: rect,
            cornerRadius: cornerRadius
            ).addClip()
        image?.draw(in: rect)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
