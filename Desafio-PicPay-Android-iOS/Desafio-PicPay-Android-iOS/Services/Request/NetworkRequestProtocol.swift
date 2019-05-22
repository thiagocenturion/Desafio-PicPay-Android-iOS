//
//  NetworkRequestProtocol.swift
//  Desafio-PicPay-Android-iOS
//
//  Created by Avanade on 21/05/19.
//  Copyright © 2019 ThiagoCenturion. All rights reserved.
//

import Foundation
import Alamofire

enum APIError: String, Error {
    case noNetwork = "noNetwork"
    case serverOverload = "serverOverload"
    case internalError = "internalError"
    case permissionDenied = "permissionDenied"
}

protocol NetworkRequestProtocol: class {
    func request<T: Decodable>(with completion: @escaping (T?, _ error: APIError?) -> Void)
}

extension NetworkRequestProtocol {
    func request<T: Decodable>(url: URL, method: HTTPMethod, with completion: @escaping (T?, _ error: APIError?) -> Void) {
        Alamofire.request(url, method: method, encoding: JSONEncoding.default).responseJSON { response in
            var responseModel: T?
            
            // Verifica o resultado da comunicação
            switch (response.result) {
            case .success:
                guard let data = response.data else {
                    completion(nil, .internalError)
                    return
                }
                
                // Realiza a decodificação com base na estrutura recebida
                do {
                    responseModel = try JSONDecoder().decode(T?.self, from: data)
                } catch let error {
                    print(error)
                    completion(nil, .internalError)
                    return
                }
                
                completion(responseModel, nil)
            
            case .failure(let error):
                print(error)
                
                if let err = error as? URLError, err.code == .notConnectedToInternet {
                    completion(nil, .noNetwork)
                } else {
                    completion(nil, .serverOverload)
                }
            }
        }
    }
}
