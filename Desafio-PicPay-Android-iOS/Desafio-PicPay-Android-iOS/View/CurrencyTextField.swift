//
//  CurrencyTextField.swift
//  Desafio-PicPay-Android-iOS
//
//  Created by Avanade on 03/07/19.
//  Copyright © 2019 ThiagoCenturion. All rights reserved.
//

import UIKit

class CurrencyTextField: UITextField, BindTextFieldProtocol {
    
    // MARK: - Properties
    
    typealias Listener = (String) -> ()
    var listener: Listener?
    
    // Limite de caracteres para o valor total da conta para 16 caracteres, os quais remente-se até um valor antes de 1 bilhão
    let limitLength = 16
    
    /// formatador numérico com localidade brasileira, como padrão, para estilo monetário
    lazy var currencyNumberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "pt-BR")
        formatter.maximumFractionDigits = 2
        formatter.currencySymbol = ""
        
        // Essa definição realiza o arredondamento da última casa, que não é utilizada em moeda por ser sempre na base 100.
        // Isso evita com que o arredondamento seja maior e, ao dividir o valor por 10, diminuir duas casas ao invés de uma.
        formatter.roundingMode = .floor
        return formatter
    }()
    
    /// Valor numérico da quantidade no label monetário, em Double.
    var amountDouble: Double {
        get {
            return currencyNumberFormatter.number(from: self.text!)?.doubleValue ?? 0.0
        }
        
        set {
            // Atribui o valor na base monetária para string, o qual insere de maneira nativa o simbolo da moeda na frente e as máscaras decimais
            let nAmount = NSNumber(value: newValue)
            self.text = currencyNumberFormatter.string(from: nAmount)
        }
    }
    
    // MARK: - View Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    // MARK: - Methods
    
    func bind(_ listener: Listener?) {
        self.listener = listener
    }
    
    func setup() {
        delegate = self
        
        font = UIFont.systemFont(ofSize: 54)
        borderStyle = .none
        
        // Colors
        tintColor = Color.secondary
        textColor = Color.secondary
        attributedPlaceholder = NSAttributedString(string: placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor : Color.placeholder])
    }
}

extension CurrencyTextField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let formatter = NumberFormatter()
        var nValueInCents: NSNumber
        var sFinalTotalValue = ""
        var nFinalTotalValue: NSNumber
        
        // Calcula o novo tamanho pressuposto somando o texto antigo com o novo, somente no tamanho do range
        let iLenghtOfNewCharacter = string.count
        let iNewLenght = textField.text!.count + iLenghtOfNewCharacter - range.length
        
        // Obtém o valor anterior, em centavos e digitado no textfield, com somente os números decimais e removendo os demais, por preucação
        let sCleanOldValueInCents = textField.text!.components(separatedBy: CharacterSet.decimalDigits.inverted).joined(separator: "")
        
        nValueInCents = formatter.number(from: sCleanOldValueInCents) ?? NSNumber()
        
        // Libera a alteração dos caracteres somente se o tamanho estiver dentro da margem de limite
        if iNewLenght < limitLength {
            
            // Caso o usuário tenha adicionado um novo número
            if iLenghtOfNewCharacter > 0 {
                
                // Adiciona o novo número na direita do valor total
                let nNewNumber = formatter.number(from: string) ?? 0.0
                nValueInCents = nValueInCents.addRight(nNewNumber.doubleValue)
            } else {
                
                // Se o novo caractere estiver vazio, significa que o usuário está apagando texto
                // Então remove o número da direita do valor total
                nValueInCents = nValueInCents.removeRight()
            }
            
        } else if iLenghtOfNewCharacter <= 0 {
            
            // Se o novo caractere estiver vazio, significa que o usuário está apagando texto
            // Então remove o número da direita do valor total
            nValueInCents = nValueInCents.removeRight()
        }
        
        // Atribui o valor na base monetária para string, o qual insere de maneira nativa o simbolo da moeda na frente e as máscaras decimais
        sFinalTotalValue = currencyNumberFormatter.string(from: nValueInCents.currencyBase) ?? ""
        
        // Caso o valor atual em centavos já seja 0, então limpa o text field completamente
        nFinalTotalValue = currencyNumberFormatter.number(from: sFinalTotalValue) ?? NSNumber()
        if nFinalTotalValue.doubleValue <= 0.0 {
            textField.text = ""
        } else {
            // Atribui o valor na base monetária para string, o qual insere de maneira nativa o simbolo da moeda na frente e as máscaras decimais
            textField.text = sFinalTotalValue
        }
        
        // Para aplicar filtro monetário, a definição do texto será manualmente e, portanto, não pode ser definido pelo texto de tela.
        listener?(textField.text ?? "")
        return false
    }
}
