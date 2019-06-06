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
    @IBOutlet weak var txtExpiryDate: DefaultTextField!
    @IBOutlet weak var txtCVV: DefaultTextField!
    @IBOutlet weak var btnSave: PrimaryButton!
    var delegate: CardRegisterViewControllerProtocol?
    weak var coordinator: CoordinatorProtocol?
    lazy var viewModel: CardRegisterViewModel = CardRegisterViewModel()
    
    // MARK: - View Lifecyle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupViewModel()
    }
    
    // MARK: - Actions
    
    @IBAction func onSave(_ sender: Any) {
        if viewModel.isValid {
            print("Salvar")
        }
    }
    
    // MARK: - Methods
    
    func setupLayout() {
        view.backgroundColor = Color.primaryBackground
        btnSave.isHidden = true
        
        // Determina uma distância maior entre o teclado e os textFields, o suficiente para que o botao seja exibido a cima do teclado, por possuir uma altura dinamica conforme o telcado exibe/esconde
        btnSave.textFieldsToSetDistanceFromKeyboard = [txtExpiryDate, txtCVV]
    }
    
    func setupViewModel() {
        // Define as máscaras dos campos
        txtCardNumber.maskPattern = viewModel.cardNumberViewModel.mask ?? ""
        txtHoldersName.maskPattern = viewModel.holdersNameViewModel.mask ?? ""
        txtExpiryDate.maskPattern = viewModel.expiryDateViewModel.mask ?? ""
        txtCVV.maskPattern = viewModel.cvvViewModel.mask ?? ""
        
        // Data bind viewModel
        viewModel.isLoading.bind { [weak self] isLoading in
            if isLoading {
                self?.view.showActivity()
            } else {
                self?.view.removeActivity()
            }
        }
        
        // Caso retorne algum erro da view model, exibe um alerta com a mensagem correta ao usuario
        viewModel.alertMessage.bind { [weak self] in self?.showAlert($0) }
        
        // Valida se a tela pode exibir o botão de Salvar para o usuário clicar
        viewModel.isCounted.bind { [weak self] in self?.btnSave.isHidden = !$0 }
        
        // Preenche no textField a label de erro quando necessário
        viewModel.cardNumberViewModel.errorMessage.bind { [weak self] in
            self?.txtCardNumber.textFieldControllerFloating.setErrorText($0, errorAccessibilityValue: $0)
        }
        viewModel.holdersNameViewModel.errorMessage.bind { [weak self] in
            self?.txtHoldersName.textFieldControllerFloating.setErrorText($0, errorAccessibilityValue: $0)
        }
        viewModel.expiryDateViewModel.errorMessage.bind { [weak self] in
            self?.txtExpiryDate.textFieldControllerFloating.setErrorText($0, errorAccessibilityValue: $0)
        }
        viewModel.cvvViewModel.errorMessage.bind { [weak self] in
            self?.txtCVV.textFieldControllerFloating.setErrorText($0, errorAccessibilityValue: $0)
        }
        
        // Data bind UI -> viewModel
        txtCardNumber.bind { [unowned self] in self.viewModel.cardNumberViewModel.text.value = $0.trimmingCharacters(in: .whitespaces) }
        txtHoldersName.bind { [unowned self] in self.viewModel.holdersNameViewModel.text.value = $0.trimmingCharacters(in: .whitespaces) }
        txtExpiryDate.bind { [unowned self] in self.viewModel.expiryDateViewModel.text.value = $0.trimmingCharacters(in: .whitespaces) }
        txtCVV.bind { [unowned self] in self.viewModel.cvvViewModel.text.value = $0.trimmingCharacters(in: .whitespaces) }
    }
    
}
