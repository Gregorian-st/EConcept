//
//  NetworkTests.swift
//  EConceptTests
//
//  Created by Grigory Stolyarov on 14.12.2022.
//

import XCTest
@testable import EConcept

final class NetworkTests: XCTestCase {
    
    private var requestFactory: RequestFactory?
    private var requestAPIEConcept: APIEConceptRequestFactoryProtocol?

    override func setUpWithError() throws {

        requestFactory = RequestFactory()
    }

    override func tearDownWithError() throws {

        requestAPIEConcept = nil
        requestFactory = nil
    }

    func testNetworkService() throws {
        
        let getMainExpectation = expectation(description: "Get Main Request Expectation")
        let getProductExpectation = expectation(description: "Get Product Request Expectation")
        let getCartExpectation = expectation(description: "Get Cart Request Expectation")
        
        requestAPIEConcept = requestFactory?.makeAPIEConceptRequestFactory()
        
        guard let requestAPIEConcept = requestAPIEConcept else {
            XCTFail("Network Service is not created")
            return
        }
        
        requestAPIEConcept.getMain { response in
            switch response.result {
            case .success(let result):
                XCTAssertNotEqual(result.homeStoreItems.count, 0)
                XCTAssertNotEqual(result.bestSellerItems.count, 0)
                getMainExpectation.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        
        requestAPIEConcept.getProductSmartphone { response in
            switch response.result {
            case .success(let result):
                XCTAssertNotEqual(result.productSmartphone.title, "")
                getProductExpectation.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        
        requestAPIEConcept.getCart { response in
            switch response.result {
            case .success(let result):
                XCTAssertNotEqual(result.cartTotal.total, 0)
                getCartExpectation.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
}
