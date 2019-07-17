//
//  UserApiRequestTest.swift
//  Desafio-PicPay-Android-iOSTests
//
//  Created by Avanade on 27/05/19.
//  Copyright © 2019 ThiagoCenturion. All rights reserved.
//

import XCTest
@testable import Desafio_PicPay_Android_iOS

class UserApiRequestTest: XCTestCase {
    var resources: UserResources!
    var sut: NetworkRequestProtocol?

    override func setUp() {
        resources = UserResources()
        sut = ApiRequest(resource: resources)
    }

    override func tearDown() {
        resources = nil
        sut = nil
        super.tearDown()
    }
    
    func testFetchContactListSuccess() {
        let sut = self.sut!
        let expect = XCTestExpectation(description: "callback")
        
        sut.request(with: { (contacts: [Contact]?, error: APIError?) in
            expect.fulfill()
            XCTAssertNil(error)
            
            if let arrContacts = contacts {
                for contact in arrContacts {
                    XCTAssertNotNil(contact.id)
                    XCTAssertNotNil(contact.name)
                    XCTAssertNotNil(contact.username)
                    XCTAssertNotNil(contact.img)
                }
            } else {
                XCTFail("Perda do resultado da requisição.")
            }
        })
        
        wait(for: [expect], timeout: 30.0)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            testFetchContactListSuccess()
        }
    }

}
