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

class CardRegisterViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var lblTitle: TitleLabel!
    @IBOutlet weak var txtCardNumber: DefaultTextField!
    @IBOutlet weak var txtHoldersName: DefaultTextField!
    @IBOutlet weak var txtValidDate: DefaultTextField!
    @IBOutlet weak var txtCVV: DefaultTextField!
    @IBOutlet weak var btnRegister: PrimaryButton!
    var delegate: CardRegisterViewControllerProtocol?
    
    // MARK: - View Lifecyle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
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
    }
    
}
