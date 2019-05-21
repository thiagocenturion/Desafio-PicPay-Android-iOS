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
    private let reuseIdentifier = ContactListCell.nameOfClass
    private var searchController: DarkSearchController?
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        setupTableView()
        
        // FIXME: Remover. Teste para ver se é possivel deixar a navigation pequena.
        navigationItem.title = ""
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func setupLayout() {
        view.backgroundColor = Color.primaryBackground
        
        searchController = ({
            let controller = DarkSearchController(searchResultsController: nil, with: 40.0)
            controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.placeholder = "ContactListSeachPlaceholder".localizable
            controller.searchBar.sizeToFit()
            return controller
        })()
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
        
        tableView.backgroundColor = Color.primaryBackground
    }
    
}

extension ContactListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return searchController?.searchBar
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        return cell
    }
}

extension ContactListViewController: UITableViewDelegate {
    // TODO: Chamar coordinator
}

extension ContactListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        // TODO: Realizar a busca para a viewModel
    }
}
