//
//  ContactListViewModel.swift
//  Desafio-PicPay-Android-iOS
//
//  Created by Avanade on 17/05/19.
//  Copyright © 2019 ThiagoCenturion. All rights reserved.
//

import UIKit

class ContactListViewModel: NSObject {
    
    // MARK: - Properties
    
    var isLoading: Dynamic<Bool> = Dynamic(false)
    var alertMessage: Dynamic<String> = Dynamic("")
    var bindReloadDataSource: (() -> Void)?
    private(set) var arrAllContactViewModels: [ContactViewModel] = [ContactViewModel]() {
        didSet {
            arrFilteredContactViewModels.removeAll()
            arrFilteredContactViewModels = arrAllContactViewModels.map({ return $0 })
        }
    }
    private(set) var arrFilteredContactViewModels: [ContactViewModel] = [ContactViewModel]() {
        didSet {
            bindReloadDataSource?()
        }
    }
    var numberOfCells: Int {
        return arrFilteredContactViewModels.count
    }
    var emptyDataSourceView: UIView? {
        return numberOfCells == 0 ? UILabel.label(text: "emptyDataSource".localizable, textColor: Color.primary) : nil
    }
    private var networkRequest: NetworkRequestProtocol?
    
    // MARK: Constructors
    
    init(networkRequest: NetworkRequestProtocol? = ApiRequest(resource: UserResources())) {
        self.networkRequest = networkRequest
        super.init()
    }
    
    // MARK: - Methods
    
    func fetchContacts() {
        isLoading.value = true
        networkRequest?.request(with: { [weak self] (contacts: [Contact]?, error: APIError?) in
            self?.isLoading.value = false
            if let error = error {
                self?.alertMessage.value = error.rawValue.localizable
            } else if let contacts = contacts {
                self?.arrAllContactViewModels = self?.createCellViewModels(contacts: contacts) ?? [ContactViewModel]()
            } else {
                self?.alertMessage.value = APIError.internalError.rawValue.localizable
            }
        })
    }
    
    func filtered(with textName: String) {
        // Se o texto for vazio, significa que nao estamos mais realizando o filtro
        let isFiltering = !textName.isEmpty
        
        // Caso nao estejamos filtrando, atribuimos o total da lista
        if !isFiltering {
            arrFilteredContactViewModels = arrAllContactViewModels.map({ return $0 })
        } else {
            // Realiza o filtro com a utilizacao de predicate
            let arrFiltered = arrAllContactViewModels.filter { $0.name?.localizedCaseInsensitiveContains(textName) ?? false || $0.username?.localizedCaseInsensitiveContains(textName) ?? false }
            arrFilteredContactViewModels = arrFiltered
        }
    }
    
    private func createCellViewModels(contacts: [Contact]) -> [ContactViewModel] {
        var arrContactViewModels = [ContactViewModel]()
        
        for contact in contacts {
            arrContactViewModels.append(ContactViewModel(with: contact))
        }
        
        return arrContactViewModels
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> ContactViewModel {
        return arrFilteredContactViewModels[indexPath.row]
    }
}
