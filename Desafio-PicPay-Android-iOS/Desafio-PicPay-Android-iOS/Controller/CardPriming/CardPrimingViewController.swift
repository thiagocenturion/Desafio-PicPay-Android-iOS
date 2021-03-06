//
//  CardPrimingViewController.swift
//  Desafio-PicPay-Android-iOS
//
//  Created by Avanade on 29/05/19.
//  Copyright © 2019 ThiagoCenturion. All rights reserved.
//

import UIKit

protocol CardPrimingViewControllerProtocol {
    func cardPrimingViewControllerOnRegister()
}

class CardPrimingViewController: UIViewController, ViewControllerCoordinatorProtocol {
    
    // MARK: - Properties
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var btnCardRegister: UIButton!
    var delegate: CardPrimingViewControllerProtocol?
    weak var coordinator: CoordinatorProtocol?
    
    // MARK: - View Lifecyle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    // MARK: - Actions
    
    @IBAction func onCardRegister(_ sender: Any) {
        delegate?.cardPrimingViewControllerOnRegister()
    }
    
    // MARK: - Methods
    
    func setupLayout() {
        view.backgroundColor = Color.primaryBackground
        lblTitle.textAlignment = .center
    }

}
