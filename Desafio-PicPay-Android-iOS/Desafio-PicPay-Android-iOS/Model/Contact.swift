//
//  Contact.swift
//  Desafio-PicPay-Android-iOS
//
//  Created by Avanade on 17/05/19.
//  Copyright © 2019 ThiagoCenturion. All rights reserved.
//

import Foundation

struct Contact: Codable {
    let id: Int?
    let name: String?
    let imgUrl: URL?
    let username: String?
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case imgUrl = "img"
        case username = "username"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int?.self, forKey: .id)
        name = try container.decode(String?.self, forKey: .name)
        username = try container.decode(String?.self, forKey: .username)

        if let imgUrlString = try container.decode(String?.self, forKey: .imgUrl) {
            imgUrl = URL(string: imgUrlString)
        } else {
            imgUrl = nil
        }
    }
    
    init(id: Int?, name: String?, imgUrlString: String?, username: String?) {
        self.id = id
        self.name = name
        self.imgUrl = URL(string: imgUrlString ?? "")
        self.username = username
    }
}
