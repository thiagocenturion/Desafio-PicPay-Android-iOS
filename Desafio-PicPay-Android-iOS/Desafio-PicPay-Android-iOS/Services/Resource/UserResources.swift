//
//  UserResources.swift
//  Desafio-PicPay-Android-iOS
//
//  Created by Avanade on 21/05/19.
//  Copyright © 2019 ThiagoCenturion. All rights reserved.
//

import Foundation
import Alamofire

struct UserResources: ApiResourceProtocol {
    var methodPath = "users"
    var method = HTTPMethod.get
}
