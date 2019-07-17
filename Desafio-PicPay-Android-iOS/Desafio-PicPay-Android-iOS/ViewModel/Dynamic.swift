//
//  Dynamic.swift
//  Desafio-PicPay-Android-iOS
//
//  Created by Avanade on 21/05/19.
//  Copyright © 2019 ThiagoCenturion. All rights reserved.
//

import Foundation

class Dynamic<T> {
    typealias Listener = (T) -> ()
    
    // MARK: - Properties
    
    var listener: Listener?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    // MARK: - Constructors
    
    init(_ v: T) {
        value = v
    }
    
    // MARK: - Methods
    
    func bind(_ listener: Listener?) {
        self.listener = listener
    }
    
    func bindAndFire(_ listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
}
