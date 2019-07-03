//
//  Coordinator.swift
//  Desafio-PicPay-Android-iOS
//
//  Created by Avanade on 17/05/19.
//  Copyright © 2019 ThiagoCenturion. All rights reserved.
//

import UIKit

protocol CoordinatorProtocol: AnyObject {
    var childCoordinators: [CoordinatorProtocol] { get set }
    var navigator: Navigator { get set }
    
    func start()
    func child(didFinish child: CoordinatorProtocol?)
}

protocol ViewControllerCoordinatorProtocol: class {
    var coordinator: CoordinatorProtocol? { get set }
}

extension CoordinatorProtocol {
    /// Responsavel por remover da fila o coordinator que está sendo finalizado por sua view controller realizando pop na navigation controller
    func child(didFinish child: CoordinatorProtocol?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
}
