//
//  DetailSceneTests.swift
//  EConceptTests
//
//  Created by Grigory Stolyarov on 14.12.2022.
//

import XCTest
@testable import EConcept

final class DetailSceneTests: XCTestCase {
    
    private var configurator: DetailSceneConfigurator?
    private var viewController: DetailSceneViewController?
    private var router: DetailSceneRoutingProtocol?
    private var interactor: DetailSceneInteractorInput?
    private var presenter: DetailScenePresenterInput?
    
    private var product = ProductSmartphone()

    override func setUpWithError() throws {
        
        product = ProductSmartphone(id: "555", title: "ChinaPhone")
    }

    override func tearDownWithError() throws {
        
        router = nil
        interactor = nil
        presenter = nil
        viewController = nil
        configurator = nil
    }

    func testFilterScene() throws {
        
        let sceneFactory = DefaultSceneFactory()
        
        configurator = DetailSceneConfigurator(sceneFactory: sceneFactory)
        guard let configurator = configurator else {
            XCTFail("Detail Scene Configurator is not created")
            return
        }
        
        viewController = sceneFactory.makeDetailScene(product: product, configurator: configurator) as? DetailSceneViewController
        guard let viewController = viewController else {
            XCTFail("Detail Scene ViewController is not created")
            return
        }
        
        router = viewController.router
        XCTAssertNotNil(router, "Detail Scene Router is not created")
        interactor = viewController.interactor
        XCTAssertNotNil(interactor, "Detail Scene Interactor is not created")
        presenter = (viewController.interactor as? DetailSceneInteractor)?.presenter
        XCTAssertNotNil(presenter, "Detail Scene Presenter is not created")
        
        interactor?.showProductDetails()
        XCTAssertEqual(viewController.detailsCaptionLabel.text, product.title)
    }
}
