//
//  ContactViewModel.swift
//  Desafio-PicPay-Android-iOS
//
//  Created by Avanade on 21/05/19.
//  Copyright © 2019 ThiagoCenturion. All rights reserved.
//

import UIKit

class ContactViewModel {
    var id: Int?
    var name: String?
    var imgUrl: URL?
    var username: String?
    
    init(with contact: Contact) {
        self.id = contact.id
        self.name = contact.name
        self.username = contact.username
        
        if let imgUrlString = contact.img {
            self.imgUrl = URL(string: imgUrlString)
        }
    }
}
