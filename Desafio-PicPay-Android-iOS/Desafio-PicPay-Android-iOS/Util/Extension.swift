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
    
    class func rounded(image: UIImage?, cornerRadius: CGFloat, borderColor: UIColor? = nil, borderWidth: CGFloat? = nil) -> UIImage? {
        let newImage: UIImage?
        let rect = CGRect(origin:CGPoint(x: 0, y: 0), size: image?.size ?? .zero)
        
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 1)

        // Corner Radius
        UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius).addClip()
        image?.draw(in: rect)
        
        // Stroke
        if let borderColor = borderColor, let borderWidth = borderWidth {
            let path = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius)
            
            borderColor.setStroke()
            path.lineWidth = borderWidth
            
            path.stroke()
        }
        
        newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
}

extension UIViewController {
    func showAlert(_ message: String) {
        let alert = UIAlertController(title: "AlertTitle".localizable, message: message, preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
