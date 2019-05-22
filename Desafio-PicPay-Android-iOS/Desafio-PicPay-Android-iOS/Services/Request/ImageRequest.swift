//
//  ImageRequest.swift
//  Desafio-PicPay-Android-iOS
//
//  Created by Avanade on 21/05/19.
//  Copyright © 2019 ThiagoCenturion. All rights reserved.
//

import UIKit

class ImageRequest {
    let url: URL
    
    init(url: URL) {
        self.url = url
    }
}

extension ImageRequest: NetworkRequestProtocol {
    func request<T: Decodable>(with completion: @escaping (T?, _ error: APIError?) -> Void) {
//        request(url: self.url, with: completion)
    }
}
