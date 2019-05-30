//
//  Navigator.swift
//  Desafio-PicPay-Android-iOS
//
//  Created by Avanade on 30/05/19.
//  Copyright © 2019 ThiagoCenturion. All rights reserved.
//

import UIKit

protocol NavigatorProtocol {
    func navigator(didPopping viewController: ViewControllerCoordinatorProtocol)
}

class Navigator: NSObject {
    
    // MARK: - Properties
    
    var navigationController: UINavigationController?
    var delegate: NavigatorProtocol?
    
    // MARK: - Constructors
    init(navigationController: UINavigationController?) {
        super.init()
        self.navigationController = navigationController
        setup()
    }
    
    // MARK: - Methods
    
    func setup() {
        navigationController?.delegate = self
    }
    
    func push(viewController: UIViewController, animated: Bool) {
        navigationController?.pushViewController(viewController, animated: animated)
    }
}

extension Navigator: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        // Obtem a view controller de onde estamos vindo
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
            return
        }
        
        // Verifica se o array ja contem a view controller. Se isso acontecer, significa que estamos empurrando um view controller de visualizacao diferente por cima, em vez de exibi-lo, entao sai.
        if navigationController.viewControllers.contains(fromViewController) {
            return
        }
        
        // Se ainda estivermos aqui, significa que estamos realizando um pop da view controller. Entao verificamos se corresponde ao protocolo que contem um coordinator
        if let viewControllerCoordinatorProtocol = fromViewController as? ViewControllerCoordinatorProtocol {
            // Estamos realizando um pop
            delegate?.navigator(didPopping: viewControllerCoordinatorProtocol)
        }
    }
}
