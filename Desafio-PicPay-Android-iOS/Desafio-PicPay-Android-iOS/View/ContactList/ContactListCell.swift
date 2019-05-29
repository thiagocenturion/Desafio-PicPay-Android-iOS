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
            lblUsername.text = contactViewModel?.username
            lblName.text = contactViewModel?.name
            
            // Realiza o download da imagem, armazenando em cache. Atribui uma imagem de placeholder opaca
            if let imgUrl = contactViewModel?.imgUrl {
                imgPerfil.af_setImage(withURL: imgUrl, placeholderImage: contactViewModel?.placeholderImage(size: imgPerfil.bounds.size))
            } else {
                imgPerfil.image = contactViewModel?.placeholderImage(size: imgPerfil.bounds.size)
            }
        }
    }
    
    // MARK: - Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Arredondamento da imagem
        imgPerfil.clipsToBounds = true
        imgPerfil.layer.cornerRadius = imgPerfil.bounds.height / 2
        
        // Selecao
        let backgroundSelectedColorView = UIView()
        backgroundSelectedColorView.backgroundColor = Color.primary.withAlphaComponent(0.1)
        selectedBackgroundView = backgroundSelectedColorView
    }
}
