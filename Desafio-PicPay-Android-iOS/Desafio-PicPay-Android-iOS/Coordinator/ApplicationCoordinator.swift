//
//  ApplicationCoordinator.swift
//  Desafio-PicPay-Android-iOS
//
//  Created by Avanade on 17/05/19.
//  Copyright © 2019 ThiagoCenturion. All rights reserved.
//

import UIKit

class ApplicationCoordinator: CoordinatorProtocol {
    let window: UIWindow
    let rootViewController: UINavigationController
    let contactListCoordinator: ContactListCoordinator
    
    init(window: UIWindow) {
        self.window = window
        
        // Cria a navigation controller que sera responsavel pelo fluxo do sistema
        rootViewController = UINavigationController()
        rootViewController.navigationBar.prefersLargeTitles = true
        rootViewController.navigationBar.barStyle = .black
        rootViewController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        rootViewController.navigationBar.barTintColor = Color.clear
        contactListCoordinator = ContactListCoordinator(presenter: rootViewController)
    }
    
    func start() {
        window.rootViewController = rootViewController
        
        contactListCoordinator.start()
        
        window.makeKeyAndVisible()
    }
}
