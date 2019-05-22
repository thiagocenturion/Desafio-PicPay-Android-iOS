//
//  ContactViewModel.swift
//  Desafio-PicPay-Android-iOS
//
//  Created by Avanade on 21/05/19.
//  Copyright © 2019 ThiagoCenturion. All rights reserved.
//

import UIKit

class ContactViewModel {
    
    // MARK: - Properties
    
    var contact: Contact
    private var networkRequest: NetworkRequestProtocol?
    
    // MARK: - Construtors
    
    init(with contact: Contact) {
        self.contact = contact
    }
    
    // MARK: - Methods
    
    func downloadImage(completion: @escaping (_ image: UIImage?, _ error: APIError?) -> Void) {
        guard let imgUrl = contact.imgUrl else {
            completion(nil, nil)
            return
        }
        
        let request = ImageRequest(url: imgUrl)
        networkRequest = request
        request.request(with: completion)
    }
}
