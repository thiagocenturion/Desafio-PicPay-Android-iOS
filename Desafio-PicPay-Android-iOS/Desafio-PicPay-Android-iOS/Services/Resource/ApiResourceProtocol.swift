//
//  ApiResourceProtocol.swift
//  Desafio-PicPay-Android-iOS
//
//  Created by Avanade on 21/05/19.
//  Copyright © 2019 ThiagoCenturion. All rights reserved.
//

import Foundation

protocol ApiResourceProtocol {
    var methodPath: String { get }
}

extension ApiResourceProtocol {
    var url: URL {
        let domainUrl = URL(string: "http://careers.picpay.com")
        let testsUrl = URL(string: "tests", relativeTo: domainUrl)!
        let baseUrl = testsUrl.appendingPathComponent("mobdev")
        return baseUrl.appendingPathComponent(methodPath)
    }
}
