//
//  PaymentViewController.swift
//  Desafio-PicPay-Android-iOS
//
//  Created by Avanade on 03/07/19.
//  Copyright © 2019 ThiagoCenturion. All rights reserved.
//

import UIKit

protocol PaymentViewControllerProtocol {
    func paymentViewController(tappedEditCard cardRegisterViewModel: CardRegisterViewModel)
    func paymentViewController(didPayment paymentViewModel: PaymentViewModel)
}

class PaymentViewController: UIViewController, ViewControllerCoordinatorProtocol {
    
    // MARK: - Properties
    
    @IBOutlet weak var imgContact: UIImageView!
    @IBOutlet weak var lblUsernameContact: UILabel!
    @IBOutlet weak var lblRs: SubtitleLabel!
    @IBOutlet weak var txtValue: CurrencyTextField!
    @IBOutlet weak var lblCreditCard: DescriptionLabel!
    @IBOutlet weak var btnEditCreditCard: UIButton!
    @IBOutlet weak var btnPay: PrimaryButton!
    var delegate: PaymentViewControllerProtocol?
    weak var coordinator: CoordinatorProtocol?
    var viewModel: PaymentViewModel = PaymentViewModel(cardViewModel: nil, contactViewModel: nil)
    
    // MARK: - Constructors
    
    init(viewModel: PaymentViewModel = PaymentViewModel(cardViewModel: nil, contactViewModel: nil)) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecyle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupViewModel()
    }
    
    // MARK: - Actions
    
    @IBAction func onPay(_ sender: Any) {
    }
    
    // MARK: - Methods

    func setupLayout() {
        view.backgroundColor = Color.primaryBackground
        btnPay.isEnabled = false
        
        // Determina uma distância maior entre o teclado e os textFields, o suficiente para que o botao seja exibido a cima do teclado, por possuir uma altura dinamica conforme o telcado exibe/esconde
        btnPay.textFieldsToSetDistanceFromKeyboard = [txtValue]
    }
    
    func setupViewModel() {
        // Caso retorne algum erro da view model, exibe um alerta com a mensagem correta ao usuario
        viewModel.alertMessage.bind { [weak self] in self?.showAlert($0) }
        
        // Valida se a tela pode exibir o botão de Salvar para o usuário clicar
        viewModel.isCounted.bind { [weak self] in self?.btnPay.isEnabled = $0 }
        
        // Data bind UI -> viewModel
        // TODO: Já passar o valor em Double direto daqui
        txtValue.bind { [unowned self] in self.viewModel.valueViewModel.text.value = $0.trimmingCharacters(in: .whitespaces) }
        
        // viewModel -> UI
        // Realiza o download da imagem, armazenando em cache. Atribui uma imagem de placeholder opaca
        if let imgUrl = viewModel.contactViewModel?.imgUrl {
            imgContact.af_setImage(withURL: imgUrl, placeholderImage: viewModel.contactViewModel?.placeholderImage(size: imgContact.bounds.size))
        } else {
            imgContact.image = viewModel.contactViewModel?.placeholderImage(size: imgContact.bounds.size)
        }
        lblUsernameContact.text = viewModel.contactViewModel?.username
        lblCreditCard.text = viewModel.cardViewModel?.cardDescription()
    }

}
