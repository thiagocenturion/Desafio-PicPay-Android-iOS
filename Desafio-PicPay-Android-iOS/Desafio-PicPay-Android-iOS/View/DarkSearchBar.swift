//
//  DarkSearchController.swift
//  Desafio-PicPay-Android-iOS
//
//  Created by Avanade on 17/05/19.
//  Copyright © 2019 ThiagoCenturion. All rights reserved.
//

import UIKit

class DarkSearchBar: UISearchBar {
    
    // MARK: - Properties
    
    var textField: UITextField?
    var searchFieldHeight: CGFloat = 0.0
    var barBackgroundColor: UIColor = UIColor.black
    var searchFieldBackgroundColor: UIColor = UIColor.darkGray
    var font: UIFont = UIFont.systemFont(ofSize: 17) {
        didSet {
            updateLayout()
        }
    }
    
    private(set) var isActive: Bool = false {
        didSet {
            updateLayout()
        }
    }
    
    private var didSet = false
    
    // Criacao de outro delegate que podera ser utilizado na controller que criou esta classe
    private weak var controllerDelegate: UISearchBarDelegate?
    
    // Garante de que sera armazenado tanto o delegate atual quanto o delegate da controller. Externamente, exibe somente o delegate da controller
    override open var delegate: UISearchBarDelegate? {
        get { return controllerDelegate }
        set { controllerDelegate = newValue }
    }
    
    // MARK: - Construtors
    
    init(frame: CGRect, searchFieldHeight: CGFloat, tintColor: UIColor? = nil, barBackgroundColor: UIColor? = nil, searchFieldBackgroundColor: UIColor? = nil) {
        super.init(frame: frame)
        self.searchFieldHeight = searchFieldHeight
        
        if let tintColor = tintColor {
            self.tintColor = tintColor
        }
        
        if let barBackgroundColor = barBackgroundColor {
            self.barBackgroundColor = barBackgroundColor
        }
        
        if let searchFieldBackgroundColor = searchFieldBackgroundColor {
            self.searchFieldBackgroundColor = searchFieldBackgroundColor
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if !didSet {
            setup()
        }
    }
    
    func setup() {
        didSet = true
        
        // Para utilizar o delegate tanto aqui na classe quanto na controller, então o delegate desta classe precisa ser aplicada ao 'super'
        super.delegate = self
        
        setupBar()
        setupSearchField()
        isActive = false
    }
    
    func setupBar() {
        barStyle = .black
    }
    
    func setupSearchField() {
        // Icones
        setImage(#imageLiteral(resourceName: "icon_clear"), for: .clear, state: .normal)
        setImage(#imageLiteral(resourceName: "icon_magnifier_white"), for: .search, state: .normal)
        
        // Fonte
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedString.Key.font:font]
    }
    
    func updateLayout() {
        // Bar Background color
        let backgroundImage = UIImage.image(with: barBackgroundColor, size: bounds.size)
        setBackgroundImage(backgroundImage, for: .any, barMetrics: .default)
        barTintColor = barBackgroundColor
        
        // Search Field Text color
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [ NSAttributedString.Key.foregroundColor: tintColor! ]
        
        // Search Field Background
        let borderColor = isActive ? tintColor : Color.clear
        var searchFieldBackImage = UIImage.image(with: searchFieldBackgroundColor, size: CGSize(width: bounds.width, height: searchFieldHeight))
        searchFieldBackImage = UIImage.rounded(image: searchFieldBackImage, cornerRadius: searchFieldHeight / 1.0, borderColor: borderColor, borderWidth: 2.0)
        setSearchFieldBackgroundImage(searchFieldBackImage, for: .normal)
        searchTextPositionAdjustment = UIOffset(horizontal: 8.0, vertical: 0.0)
        
        // Center
        let adjustmentOffset: UIOffset
        if isActive {
            adjustmentOffset = UIOffset(horizontal: 0, vertical: 0)
        } else {
            let currentText = text?.isEmpty == true ? placeholder : text
            let textWidth = (currentText as NSString?)?.size(withAttributes: [NSAttributedString.Key.font:font]).width ?? 0
            let searchWidth = image(for: .search, state: .normal)?.size.width ?? 0
            let textPaddingWidth = searchTextPositionAdjustment.horizontal * 2
            
            // TODO: Enconrtar uma maneira de capturar a margin entre o searchBar e o searchField
            let searchBackgroundWidth = textPaddingWidth * 2
            let width = frame.width - (textWidth + textPaddingWidth + searchWidth + searchBackgroundWidth)
            adjustmentOffset = UIOffset(horizontal: width / 2, vertical: 0)
        }
        
        setPositionAdjustment(adjustmentOffset, for: .search)
    }
}

extension DarkSearchBar: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        // Deixa o searchBar no modo ativo
        isActive = true
        return controllerDelegate?.searchBarShouldBeginEditing?(searchBar) ?? true
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        // Remove o searchBar do modo ativo
        isActive = false
        return controllerDelegate?.searchBarShouldEndEditing?(searchBar) ?? true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        endEditing(true)
        controllerDelegate?.searchBarSearchButtonClicked?(searchBar)
    }
}
