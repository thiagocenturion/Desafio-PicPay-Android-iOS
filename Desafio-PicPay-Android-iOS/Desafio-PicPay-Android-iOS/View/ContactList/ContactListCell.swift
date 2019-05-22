//
//  ContactListCell.swift
//  Desafio-PicPay-Android-iOS
//
//  Created by Avanade on 17/05/19.
//  Copyright © 2019 ThiagoCenturion. All rights reserved.
//

import UIKit

class ContactListCell: UITableViewCell {
    
    // MARK: - Properties
    @IBOutlet weak var imgPerfil: UIImageView!
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var lblName: UILabel!
    var contactViewModel : ContactViewModel? {
        didSet {
            lblUsername.text = contactViewModel?.contact.username
            lblName.text = contactViewModel?.contact.name
            
            // TODO: Realizar o download da imagem e inserir no UI
        }
    }
    
}
