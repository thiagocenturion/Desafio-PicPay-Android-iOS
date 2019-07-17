//
//  MovingKeyboardButton.swift
//  Desafio-PicPay-Android-iOS
//
//  Created by Avanade on 31/05/19.
//  Copyright © 2019 ThiagoCenturion. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class KeyboardMovingButton: UIButton {
    
    /**
     São os textFields que deseja-se mover para cima mais do que o valor padrão utilizado pelo IQKeyboardManager, o suficiente para exibir o botão caso esteja definido isMoveWithKeyboard = true.
     */
    var textFieldsToSetDistanceFromKeyboard: [UITextField]? {
        didSet {
            setupKeyboardDistanceFromTextField()
        }
    }

    /**
     Define se o botão deve mover para cima quando o keyboard for exibido. Ele irá pegar a bottom constraint e alterar seu constant com a altura do teclado, quando o teclado estiver exibindo. É aconselhavel existir uma top constraint greaterThanOrEqual para que o botão não sobrescreva o conteúdo. O valor padrão é Verdadeiro.
     */
    @IBInspectable dynamic open var isMoveWithKeyboard: Bool = true {
        didSet {
            subscribeKeyboardNotifications()
            setupKeyboardDistanceFromTextField()
        }
    }
    
    private var isLoaded: Bool = false
    private var originalBottomConstraintConstant: CGFloat = 0
    
    // MARK: - Constructors
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    deinit {
        unsubscribeKeyboardNotifications()
    }
    
    // MARK: - View Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if !isLoaded {
            isLoaded = !isLoaded
            
            // Armazena o valor original da constraint, para sempre devolver quando o teclado for escondido
            originalBottomConstraintConstant = constraint(.bottom)?.constant ?? originalBottomConstraintConstant
        }
    }
    
    // MARK: - Methods
    
    func setup() {
        subscribeKeyboardNotifications()
    }
    
    func setupKeyboardDistanceFromTextField() {
        guard isMoveWithKeyboard else { return }
        guard let arrTextFieldsToSetDistanceFromKeyboard = textFieldsToSetDistanceFromKeyboard else { return }
        
        // Define a distancia minima entre os textfields recebidos da tela e o teclado sendo suficiente para mostrar o botão
        let topConstraintConstant = constraint(.top)?.constant ?? 0
        let bottomConstraintConstant = constraint(.bottom)?.constant ?? 0
        for textField in arrTextFieldsToSetDistanceFromKeyboard {
            // A distancia entre o text field e o teclado deve ser o botão e seus constraints verticais (top e bottom)
            textField.keyboardDistanceFromTextField = topConstraintConstant + bottomConstraintConstant + bounds.height
        }
    }
    
    func subscribeKeyboardNotifications() {
        guard isMoveWithKeyboard else { return }
        
        unsubscribeKeyboardNotifications()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeKeyboardNotifications() {
        guard isMoveWithKeyboard else { return }
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        // Obtem a altura do teclado
        let keyboardSize = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
        if let keyboardHeight = keyboardSize?.cgRectValue.height {
            // Atribui a constraint inferior do botao a altura do telado
            constraint(.bottom)?.constant = keyboardHeight
            
            // Realiza a animação para que o botao suba conforme o teclado aparece
            let animationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double
            UIView.animate(withDuration: animationDuration ?? 1.0) { [weak self] in
                self?.parentContainerViewController()?.view.layoutIfNeeded()
            }
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        // Retorna a constraint inferior do botao ao seu valor original
        constraint(.bottom)?.constant = originalBottomConstraintConstant
        
        // Realiza a animacao para que o botao volte conforme o teclado desaparece
        let animationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double
        UIView.animate(withDuration: animationDuration ?? 1.0) { [weak self] in
            self?.parentContainerViewController()?.view.layoutIfNeeded()
        }
    }

}
