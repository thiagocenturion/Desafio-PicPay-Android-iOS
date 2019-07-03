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
    
    /**
     Realiza uma formatação na string conforme mascara fornecida por 'pattern' e o caractere de substituicao.
     
     - parameter pattern:  Usa por exemplo "+## (##) #####-####".
     - parameter replacmentCharacter: é o caractere que será substituido pelos caracteres do texto original.
     - Returns: Uma string contendo a formatacao requerida conforme a mascara fornecida.
     */
    func formatted(mask: String, replacmentCharacter: Character) -> String {
        var result = ""
        
        // Remove a mascara atual
        let originalText = self.removeFormatted(mask: mask, replacmentCharacter: replacmentCharacter)
        
        // Percorre os caracteres da mascara para
        var index = originalText.startIndex
        for character in mask where index < originalText.endIndex {
            // Caso seja o caractere de substituição, adiciona o caractere do texto original e incrementa o index
            if character == replacmentCharacter {
                result.append(originalText[index])
                index = originalText.index(after: index)
            } else {
                // Adiciona o caractere da mascara
                result.append(character)
            }
        }
        
        return result
    }
    
    func removeFormatted(mask: String, replacmentCharacter: Character) -> String {
        var result = self
        
        // Extrai da mascara os caracteres de substituicao
        let maskWithoutReplacment = mask.replacingOccurrences(of: String(replacmentCharacter), with: "")
        
        // Percorre cada um dos caracteres da máscara e remove todas as ocorrencias existentes desta string
        for character in maskWithoutReplacment {
            result = result.replacingOccurrences(of: String(character), with: "")
        }
        
        return result
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

extension UILabel {
    class func label(text: String?, font: UIFont? = UIFont.systemFont(ofSize: 17), textColor: UIColor? = Color.black) -> UILabel {
        let label = UILabel(frame: .zero)
        label.text = text
        label.font = font
        label.textColor = textColor
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }
}

extension UIView {
    func showActivity() {
        let activity = UIActivityIndicatorView(style: .whiteLarge)
        activity.hidesWhenStopped = true
        
        activity.translatesAutoresizingMaskIntoConstraints = false
        addSubview(activity)
        
        let horizontalConstraint = activity.centerXAnchor.constraint(equalTo: centerXAnchor)
        let verticalConstraint = activity.centerYAnchor.constraint(equalTo: centerYAnchor)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint])
        
        activity.startAnimating()
    }
    
    public func removeActivity() {
        for subview in subviews.reversed() {
            if let activity = subview as? UIActivityIndicatorView {
                DispatchQueue.main.async { [weak activity] in
                    activity?.stopAnimating()
                    activity?.removeFromSuperview()
                }
            }
        }
    }
    
    func constraint(_ firstAttribute: NSLayoutConstraint.Attribute) -> NSLayoutConstraint? {
        return superview?.constraints.filter({ $0.firstAttribute == firstAttribute }).first
    }
}
