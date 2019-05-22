//
//  ContactListCell.swift
//  Desafio-PicPay-Android-iOS
//
//  Created by Avanade on 17/05/19.
//  Copyright © 2019 ThiagoCenturion. All rights reserved.
//

import UIKit
import AlamofireImage

class ContactListCell: UITableViewCell {
    
    // MARK: - Properties
    
    @IBOutlet weak var imgPerfil: UIImageView!
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var lblName: UILabel!
    var contactViewModel : ContactViewModel? {
        didSet {
            lblUsername.text = contactViewModel?.contact.username
            lblName.text = contactViewModel?.contact.name
            
            // Realiza o download da imagem, armazenando em cache. Atribui uma imagem de placeholder opaca
            if let imgUrl = contactViewModel?.contact.imgUrl {
                imgPerfil.af_setImage(withURL: imgUrl, placeholderImage: UIImage.image(with: Color.fourth, size: imgPerfil.bounds.size))
            }
        }
    }
    
    // MARK: - Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Arredondamento da imagem
        imgPerfil.clipsToBounds = true
        imgPerfil.layer.cornerRadius = imgPerfil.bounds.height / 2
    }
}
