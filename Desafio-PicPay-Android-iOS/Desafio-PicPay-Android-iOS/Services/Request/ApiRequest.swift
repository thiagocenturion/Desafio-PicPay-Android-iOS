//
//  ApiRequest.swift
//  Desafio-PicPay-Android-iOS
//
//  Created by Avanade on 21/05/19.
//  Copyright © 2019 ThiagoCenturion. All rights reserved.
//

import Foundation

class ApiRequest<Resource: ApiResourceProtocol> {
    let resource: Resource
    
    init(resource: Resource) {
        self.resource = resource
    }
}

extension ApiRequest: NetworkRequestProtocol {
    func request<T: Decodable>(with completion: @escaping (T?, _ error: APIError?) -> Void) {
        request(url: self.resource.url, method: self.resource.method, with: completion)
    }
}
