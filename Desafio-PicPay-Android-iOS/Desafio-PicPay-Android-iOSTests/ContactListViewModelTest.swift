//
//  ContactListVIewModelTest.swift
//  Desafio-PicPay-Android-iOSTests
//
//  Created by Avanade on 26/05/19.
//  Copyright © 2019 ThiagoCenturion. All rights reserved.
//

import XCTest
@testable import Desafio_PicPay_Android_iOS

class ContactListViewModelTest: XCTestCase {
    var mockApiRequest: MockApiRequest! = nil
    var sut: ContactListViewModel! = nil

    override func setUp() {
        mockApiRequest = MockApiRequest()
        sut = ContactListViewModel(networkRequest: mockApiRequest)
    }

    override func tearDown() {
        sut = nil
        mockApiRequest = nil
        super.tearDown()
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testRequestCalled() {
        sut.fetchContacts()
        XCTAssert(mockApiRequest.isRequestCalled)
    }
    
    func testRequestCalledFailed() {
        let error = APIError.serverOverload
        
        sut.fetchContacts()
        mockApiRequest.requestFail(error: error)
        
        XCTAssertEqual(sut.alertMessage.value, error.rawValue.localizable)
    }
    
    func testRequestCalledSuccessed() {
        sut.fetchContacts()
        mockApiRequest.requestSuccess()
        
        XCTAssertFalse(sut.arrAllContactViewModels.isEmpty)
        XCTAssertFalse(sut.arrFilteredContactViewModels.isEmpty)
    }
    
    func testCreateCellViewModel() {
        let stubContacts = Stub().stubContacts()
        let expect = XCTestExpectation(description: "Chamada de reload closure")
        sut.bindReloadDataSource = {
            expect.fulfill()
        }
        
        sut.fetchContacts()
        mockApiRequest.requestSuccess(stubContacts)
        
        // O numero de cell view models tem que ser igual ao numero de contatos
        XCTAssertEqual(sut.numberOfCells, stubContacts.count)
        
        wait(for: [expect], timeout: 1.0)
    }
    
    func testLoadingWhenRequesting() {
        var loadingStatus = false
        let expect = XCTestExpectation(description: "Atualização de status de carregamento")
        sut.isLoading.bind { isLoading in
            loadingStatus = isLoading
            expect.fulfill()
        }
        
        sut.fetchContacts()
        
        // Como iniciamos a requisicao, ele precisa estar carregando
        XCTAssertTrue(loadingStatus)
        
        // Agora significa que terminou a requisicao, isLoading precisa estar desligado
        mockApiRequest.requestSuccess()
        XCTAssertFalse(loadingStatus)
        
        wait(for: [expect], timeout: 1.0)
    }
    
    func testFilteredContacts() {
        let stubContacts = Stub().stubContacts()
        let expect = XCTestExpectation(description: "Filtro de busca")
        let contactEduardo = stubContacts.first(where: { $0.id == 1001 })
        sut.bindReloadDataSource = {
            expect.fulfill()
        }
        
        sut.fetchContacts()
        mockApiRequest.requestSuccess(stubContacts)
        
        // Testa se trouxe o perfil do Eduardo
        sut.filtered(with: "Eduardo")
        let cellViewModelNormal = sut.getCellViewModel(at: IndexPath(row: 0, section: 0))
        XCTAssertEqual(cellViewModelNormal.id, contactEduardo?.id)
        
        // Existem duas marias
        sut.filtered(with: "Maria")
        XCTAssertTrue(sut.numberOfCells == 2)
        
        // Depois de filtrado, após retornar para um campo vazio, deve-se repreencher a tabela com a lista completa novamente
        sut.filtered(with: "")
        XCTAssertEqual(sut.numberOfCells, stubContacts.count)
        
        wait(for: [expect], timeout: 3.0)
    }
    
    func testEmptyDataSource() {
        let emptyContacts = [Contact]()
        let expect = XCTestExpectation(description: "Dados vazios na table view.")
        sut.bindReloadDataSource = {
            expect.fulfill()
        }
        
        sut.fetchContacts()
        mockApiRequest.requestSuccess(emptyContacts)
        
        // Precisa retornar uma UIView nao nula e que possui um label cujo texto exibe ao usuario a mensagem de que nao existe pessoas para realizar deposito
        if let emptyLabel = sut.emptyDataSourceView as? UILabel {
            XCTAssertEqual(emptyLabel.text, "emptyDataSource".localizable)
        } else {
            XCTFail()
        }
        
        wait(for: [expect], timeout: 1.0)
    }
    
    func testCellViewModel() {
        let contact = Contact(id: 1001, name: "Eduardo Santos", img: "https://randomuser.me/api/portraits/men/9.jpg", username: "@eduardo.santos")
        
        let contactViewModel = ContactViewModel(with: contact)
        
        // Garante que os dados nao foram alterados ao transcrever a model para a cell view model
        XCTAssertEqual(contactViewModel.id, contact.id)
        XCTAssertEqual(contactViewModel.name, contact.name)
        XCTAssertEqual(contactViewModel.username, contact.username)
        XCTAssertEqual(contactViewModel.imgUrl?.absoluteString, contact.img)
    }
    
    func testCellViewModelImageNotExists() {
        let contactImageNotExists = Contact(id: 1032, name: "Paulo Noronha", img: "", username: "@paulo.noronha")
        
        let contactViewModelImageNotExists = ContactViewModel(with: contactImageNotExists)
        
        // Como não ha uma url string valida, nao deve existir um URL
        XCTAssertNil(contactViewModelImageNotExists.imgUrl)
    }
    
}

class MockApiRequest: NetworkRequestProtocol {
    var isRequestCalled = false
    var completionClosure: (([Contact]?, APIError?) -> Void)!
    
    func request<T>(with completion: @escaping (T?, APIError?) -> Void) where T : Decodable {
        isRequestCalled = true
        completionClosure = completion as? (([Contact]?, APIError?) -> Void)
    }
    
    func requestSuccess(_ contacts: [Contact] = Stub().stubContacts()) {
        completionClosure(contacts, nil)
    }
    
    func requestFail(error: APIError?) {
        completionClosure(nil, error)
    }
    
}

class Stub {
    func stubContacts() -> [Contact] {
        return [
            Contact(id: 1001, name: "Eduardo Santos", img: "https://randomuser.me/api/portraits/men/9.jpg", username: "@eduardo.santos"),
            Contact(id: 1002, name: "Marina Coelho", img: "https://randomuser.me/api/portraits/women/37.jpg", username: "@marina.coelho"),
            Contact(id: 1003, name: "Márcia da Silva", img: "https://randomuser.me/api/portraits/women/57.jpg", username: "@marcia.silva"),
            Contact(id: 1019, name: "Maria Torres", img: "https://randomuser.me/api/portraits/women/34.jpg", username: "@maria.torres"),
            Contact(id: 1031, name: "Maria Medeiros", img: "https://randomuser.me/api/portraits/women/77.jpg", username: "@maria.medeiros"),
            Contact(id: 1032, name: "Paulo Noronha", img: "https://randomuser.me/api/portraits/men/68.jpg", username: "@paulo.noronha"),
            Contact(id: 1033, name: "Mário Campos", img: "https://randomuser.me/api/portraits/men/35.jpg", username: "@mario.campos")
        ]
    }
    
}
