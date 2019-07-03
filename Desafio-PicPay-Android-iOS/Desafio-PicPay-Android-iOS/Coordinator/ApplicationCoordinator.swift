//
//  ApplicationCoordinator.swift
//  Desafio-PicPay-Android-iOS
//
//  Created by Avanade on 17/05/19.
//  Copyright © 2019 ThiagoCenturion. All rights reserved.
//

import UIKit

class ApplicationCoordinator: NSObject, CoordinatorProtocol {
    var childCoordinators = [CoordinatorProtocol]()
    var navigator: Navigator
    let window: UIWindow
    
    init(window: UIWindow, navigationController: UINavigationController? = DefaultNavigationController()) {
        self.window = window
        navigator = Navigator(navigationController: navigationController)
    }
    
    func start() {
        window.rootViewController = navigator.navigationController
        
        // Criacao do coordinator filho principal e ja inicia
        let childCoordinator = ContactListCoordinator(navigator: navigator)
        childCoordinators.append(childCoordinator)
        childCoordinator.start()
        
        window.makeKeyAndVisible()
    }
}
