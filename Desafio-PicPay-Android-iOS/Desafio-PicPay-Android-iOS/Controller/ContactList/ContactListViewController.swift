//
//  ContactListViewController2.swift
//  Desafio-PicPay-Android-iOS
//
//  Created by Avanade on 17/05/19.
//  Copyright © 2019 ThiagoCenturion. All rights reserved.
//

import UIKit

class ContactListViewController: UIViewController {
    
    // MARK: - Properties

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
    private let reuseIdentifier = ContactListCell.nameOfClass
    private let searchFieldHeight: CGFloat = 40.0
    private var searchBar: DarkSearchBar?
    lazy var viewModel: ContactListViewModel = {
        return ContactListViewModel()
    }()
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        setupTableView()
        setupViewModel()
    }
    
    func setupLayout() {
        view.backgroundColor = Color.primaryBackground
        
        searchBar = ({
            let searchBar = DarkSearchBar(frame: .zero, searchFieldHeight: searchFieldHeight, tintColor: Color.primary, barBackgroundColor: Color.primaryBackground, searchFieldBackgroundColor: Color.fourth)
            searchBar.delegate = self
            searchBar.placeholder = "ContactListSeachPlaceholder".localizable
            return searchBar
        })()
        
        // Remove o navigation nesta tela
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func setupTableView() {
        let nib = UINib(nibName: ContactListCell.nameOfClass, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: reuseIdentifier)
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 44
        tableView.estimatedSectionHeaderHeight = 25
        tableView.rowHeight = UITableView.automaticDimension
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func setupViewModel() {
        // Data binding
        viewModel.bindReloadDataSource = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        viewModel.isLoading.bind { [weak self] isLoading in
            if isLoading {
                self?.activity?.startAnimating()
            } else {
                self?.activity?.stopAnimating()
            }
        }
        
        viewModel.alertMessage.bind { [weak self] (alertMessage) in
            self?.showAlert(alertMessage)
        }
        
        // Inicia o carregamento dos dados
        viewModel.fetchContacts()
    }
}

extension ContactListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return searchBar
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? ContactListCell else {
            fatalError("No cell registered.")
        }
        let cellViewModel = viewModel.getCellViewModel(at: indexPath)
        cell.contactViewModel = cellViewModel
        return cell
    }
}

extension ContactListViewController: UITableViewDelegate {
    // TODO: Chamar coordinator
}

extension ContactListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // TODO: Realização do filtro. Inclui quando o botão "limpar" é clicado, que devemos dar reloadData com a lista inteira.
    }
}
