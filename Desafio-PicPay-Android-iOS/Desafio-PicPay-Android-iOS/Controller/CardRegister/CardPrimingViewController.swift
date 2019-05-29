//
//  CardPrimingViewController.swift
//  Desafio-PicPay-Android-iOS
//
//  Created by Avanade on 29/05/19.
//  Copyright © 2019 ThiagoCenturion. All rights reserved.
//

import UIKit

protocol CardPrimingViewControllerProtocol {
    func cardPrimingViewControllerOnCardRegister()
}

class CardPrimingViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var btnCardRegister: UIButton!
    var delegate: CardPrimingViewControllerProtocol?
    
    // MARK: - Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        setupLayout()
    }
    
    func setupLayout() {
        view.backgroundColor = Color.primaryBackground
    }
    
    @IBAction func onCardRegister(_ sender: Any) {
        delegate?.cardPrimingViewControllerOnCardRegister()
    }

}
