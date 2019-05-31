//
//  CardRegisterViewController.swift
//  Desafio-PicPay-Android-iOS
//
//  Created by Avanade on 29/05/19.
//  Copyright © 2019 ThiagoCenturion. All rights reserved.
//

import UIKit

protocol CardRegisterViewControllerProtocol {
    func cardRegisterViewController(didRegister card: Card)
}

class CardRegisterViewController: UIViewController, ViewControllerCoordinatorProtocol {
    
    // MARK: - Properties
    
    @IBOutlet weak var lblTitle: TitleLabel!
    @IBOutlet weak var txtCardNumber: DefaultTextField!
    @IBOutlet weak var txtHoldersName: DefaultTextField!
    @IBOutlet weak var txtValidDate: DefaultTextField!
    @IBOutlet weak var txtCVV: DefaultTextField!
    @IBOutlet weak var btnRegister: PrimaryButton!
    @IBOutlet weak var btnRegisterBottomConstraint: NSLayoutConstraint!
    var delegate: CardRegisterViewControllerProtocol?
    weak var coordinator: CoordinatorProtocol?
    private var btnRegisterBottomConstraintConstant: CGFloat = 0
    
    // MARK: - View Lifecyle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        subscribeKeyboardNotifications()
    }
    
    deinit {
        unsubscribeKeyboardNotifications()
    }
    
    // MARK: - Actions
    
    @IBAction func onRegister(_ sender: Any) {
        // TODO: Realizar as validações pela view model
//        let card = Card(cardNumber: <#T##String#>, holdersName: <#T##String#>, expiryDate: <#T##String#>, CVV: <#T##Int#>)
//        delegate?.cardRegisterViewController(didRegister: card)
    }
    
    // MARK: - Methods
    
    func setupLayout() {
        view.backgroundColor = Color.primaryBackground
        btnRegister.isHidden = true
        
        txtCardNumber.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        txtHoldersName.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        txtValidDate.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        txtCVV.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        
        btnRegisterBottomConstraintConstant = btnRegisterBottomConstraint.constant
    }
    
    func subscribeKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        let keyboardSize = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
        if let keyboardHeight = keyboardSize?.cgRectValue.height {
            btnRegisterBottomConstraint.constant = keyboardHeight
            
            let animationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double
            UIView.animate(withDuration: animationDuration ?? 1.0) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        btnRegisterBottomConstraint.constant = btnRegisterBottomConstraintConstant
        
        let animationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double
        UIView.animate(withDuration: animationDuration ?? 1.0) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func textFieldEditingChanged(_ textField: UITextField) {
        // Atualiza o estado do botão para salvar
        btnRegister.isHidden = txtCardNumber.text!.isEmpty || txtHoldersName.text!.isEmpty || txtValidDate.text!.isEmpty || txtCVV.text!.isEmpty
    }
    
}
