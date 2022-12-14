//
//  HomeSceneTests.swift
//  EConceptTests
//
//  Created by Grigory Stolyarov on 14.12.2022.
//

import XCTest
@testable import EConcept

final class HomeSceneTests: XCTestCase {
    
    private var configurator: HomeSceneConfigurator?
    private var viewController: HomeSceneViewController?
    private var router: HomeSceneRoutingProtocol?
    private var interactor: HomeSceneInteractorInput?
    private var presenter: HomeScenePresenterInput?
    private var networker: HomeSceneNetWorkerProtocol?

    override func tearDownWithError() throws {
        
        router = nil
        interactor = nil
        presenter = nil
        networker = nil
        viewController = nil
        configurator = nil
    }

    func testHomeScene() throws {
        
        let sceneFactory = DefaultSceneFactory()
        
        configurator = HomeSceneConfigurator(sceneFactory: sceneFactory)
        guard let configurator = configurator else {
            XCTFail("Home Scene Configurator is not created")
            return
        }
        
        viewController = sceneFactory.makeHomeScene(configurator: configurator) as? HomeSceneViewController
        guard let viewController = viewController else {
            XCTFail("Home Scene ViewController is not created")
            return
        }
        
        router = viewController.router
        XCTAssertNotNil(router, "Home Scene Router is not created")
        interactor = viewController.interactor
        XCTAssertNotNil(interactor, "Home Scene Interactor is not created")
        presenter = (viewController.interactor as? HomeSceneInteractor)?.presenter
        XCTAssertNotNil(presenter, "Home Scene Presenter is not created")
        networker = (viewController.interactor as? HomeSceneInteractor)?.netWorker
        XCTAssertNotNil(networker, "Home Scene Networker is not created")
    }
}
