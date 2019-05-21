//
//  ContactListCoordinator.swift
//  Desafio-PicPay-Android-iOS
//
//  Created by Avanade on 17/05/19.
//  Copyright © 2019 ThiagoCenturion. All rights reserved.
//

import UIKit

class ContactListCoordinator: CoordinatorProtocol {
    private let presenter: UINavigationController
    private var contactListViewController: ContactListViewController?
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
    }
    
    func start() {
        // Instancia a viewController principal do coordinator e realiza o push no navigation controller para apresentar na tela
        let contactListViewController = ContactListViewController(nibName: nil, bundle: nil)
        contactListViewController.title = "ContactListTitle".localizable
        presenter.pushViewController(contactListViewController, animated: true)
        
        self.contactListViewController = contactListViewController
    }
}
