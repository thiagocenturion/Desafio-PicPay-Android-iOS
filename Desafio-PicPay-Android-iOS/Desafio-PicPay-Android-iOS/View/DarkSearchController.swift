//
//  DarkSearchController.swift
//  Desafio-PicPay-Android-iOS
//
//  Created by Avanade on 17/05/19.
//  Copyright © 2019 ThiagoCenturion. All rights reserved.
//

import UIKit

class DarkSearchController: UISearchController {
    
    var textField: UITextField?
    var fieldHeight: CGFloat = 0.0
    
    lazy var hiddenCancelButtonSearchBar: HiddenCancelButtonSearchBar = {
        [unowned self] in
        let result = HiddenCancelButtonSearchBar(frame: CGRect.zero)
        return result
        }()
    
    override var searchBar: UISearchBar {
        get {
            return hiddenCancelButtonSearchBar
        }
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(searchResultsController: UIViewController?, with fieldHeight: CGFloat) {
        super.init(searchResultsController: searchResultsController)
        self.fieldHeight = fieldHeight
        setup()
    }
    
    func setup() {
        searchBar.barStyle = .black
        
        // Cores
        searchBar.tintColor = Color.primary
        let backgroundColor = Color.primaryBackground
        searchBar.barTintColor = backgroundColor
        let backgroundImage = UIImage.image(with: backgroundColor, size: searchBar.bounds.size)
        searchBar.setBackgroundImage(backgroundImage, for: .any, barMetrics: .default)
        
        // Search field: Cor e arredondamento
        var searchFieldBackImage = UIImage.image(with: Color.fourth, size: CGSize(width: searchBar.bounds.width, height: fieldHeight))
        searchFieldBackImage = UIImage.rounded(image: searchFieldBackImage, cornerRadius: fieldHeight / 2.0)
        searchBar.setSearchFieldBackgroundImage(searchFieldBackImage, for: .normal)
    }

}

class HiddenCancelButtonSearchBar: UISearchBar {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setShowsCancelButton(false, animated: false)
    }
}

