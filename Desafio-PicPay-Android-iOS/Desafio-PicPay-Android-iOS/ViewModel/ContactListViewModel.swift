//
//  ContactListViewModel.swift
//  Desafio-PicPay-Android-iOS
//
//  Created by Avanade on 17/05/19.
//  Copyright © 2019 ThiagoCenturion. All rights reserved.
//

import Foundation

class ContactListViewModel: NSObject {
    
    // MARK: - Properties
    
    var isLoading: Dynamic<Bool> = Dynamic(false)
    var alertMessage: Dynamic<String> = Dynamic("")
    var bindReloadDataSource: (() -> Void)?
    var arrAllContactViewModels: [ContactViewModel] = [ContactViewModel]() {
        didSet {
            arrFilteredContactViewModels.removeAll()
            arrFilteredContactViewModels = arrAllContactViewModels.map({ return $0 })
        }
    }
    var arrFilteredContactViewModels: [ContactViewModel] = [ContactViewModel]() { didSet { bindReloadDataSource?() } }
    var numberOfCells: Int {
        return arrFilteredContactViewModels.count
    }
    private var cachedContacts: [Contact] = [Contact]()
    private var networkRequest: NetworkRequestProtocol?
    
    // MARK: Constructors
    
    init(networkRequest: NetworkRequestProtocol? = ApiRequest(resource: UserResources())) {
        self.networkRequest = networkRequest
        super.init()
    }
    
    // MARK: - Methods
    
    func fetchContacts() {
        isLoading = Dynamic(true)
        networkRequest?.request(with: { [weak self] (contacts: [Contact]?, error: APIError?) in
            self?.isLoading = Dynamic(false)
            if let error = error {
                self?.alertMessage = Dynamic(error.localizedDescription.localizable)
            } else {
                self?.processFetched(contacts: contacts)
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
            let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", textName)
            let arrFiltered = (arrAllContactViewModels as NSArray?)?.filtered(using: searchPredicate)
            if let arrFilteredContacts = arrFiltered as? [Contact] {
                arrFilteredContactViewModels = createCellViewModels(contacts: arrFilteredContacts)
            }
        }
    }
    
    private func processFetched(contacts: [Contact]?) {
        guard let arrContacts = contacts else { return }
        
        self.cachedContacts = arrContacts // Cache
        
        self.arrAllContactViewModels = createCellViewModels(contacts: arrContacts)
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
