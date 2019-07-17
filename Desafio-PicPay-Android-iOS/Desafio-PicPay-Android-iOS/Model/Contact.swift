//
//  Contact.swift
//  Desafio-PicPay-Android-iOS
//
//  Created by Avanade on 17/05/19.
//  Copyright © 2019 ThiagoCenturion. All rights reserved.
//

import Foundation

/**
 Representacao de um contato, cujo ID pode ser utilizado para receber pagamentos.
 */
struct Contact: Decodable {
    let id: Int?
    let name: String?
    let img: String?
    let username: String?
}
