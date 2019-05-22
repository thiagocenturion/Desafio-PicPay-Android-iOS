//
//  NetworkRequestProtocol.swift
//  Desafio-PicPay-Android-iOS
//
//  Created by Avanade on 21/05/19.
//  Copyright © 2019 ThiagoCenturion. All rights reserved.
//

import Foundation

enum APIError: String, Error {
    case noNetwork = "noNetwork"
    case serverOverload = "serverOverload"
    case permissionDenied = "permissionDenied"
}

protocol NetworkRequestProtocol: class {
    func request<T>(with completion: @escaping (T?, _ error: APIError?) -> Void)
}

extension NetworkRequestProtocol {
    func request<T>(url: URL, with completion: @escaping (T?, _ error: APIError?) -> Void) {
        // TODO: Alamofire
    }
}
