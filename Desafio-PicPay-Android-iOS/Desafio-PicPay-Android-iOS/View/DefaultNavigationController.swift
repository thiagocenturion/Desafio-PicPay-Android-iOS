//
//  DefaultNavigationController.swift
//  Desafio-PicPay-Android-iOS
//
//  Created by Avanade on 30/05/19.
//  Copyright © 2019 ThiagoCenturion. All rights reserved.
//

import UIKit

class DefaultNavigationController: UINavigationController {
    
    override init(rootViewController: UIViewController? = nil) {
        if let rootViewController = rootViewController {
            super.init(rootViewController: rootViewController)
        } else {
            super.init(nibName: nil, bundle: nil)
        }
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        navigationBar.barStyle = .black
        navigationBar.isTranslucent = false
        navigationBar.barTintColor = Color.primaryBackground
        navigationBar.tintColor = Color.secondary
        navigationBar.shadowImage = UIImage() // Remove linha 1px abaixo da navigation
    }

}
