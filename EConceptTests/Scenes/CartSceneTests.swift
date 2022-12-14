//
//  CartSceneTests.swift
//  EConceptTests
//
//  Created by Grigory Stolyarov on 14.12.2022.
//

import XCTest
@testable import EConcept

final class CartSceneTests: XCTestCase {
    
    private var configurator: CartSceneConfigurator?
    private var viewController: CartSceneViewController?
    private var router: CartSceneRoutingProtocol?
    private var interactor: CartSceneInteractorInput?
    private var presenter: CartScenePresenterInput?
    
    private var cartTotal = CartTotal()

    override func setUpWithError() throws {
        
        cartTotal = CartTotal(id: "345",
                              total: 555,
                              delivery: "Some money",
                              items: [CartItem(id: 845, title: "YourLastPhone")])
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
        
        configurator = CartSceneConfigurator(sceneFactory: sceneFactory)
        guard let configurator = configurator else {
            XCTFail("Cart Scene Configurator is not created")
            return
        }
        
        viewController = sceneFactory.makeCartScene(cartTotal: cartTotal, configurator: configurator) as? CartSceneViewController
        guard let viewController = viewController else {
            XCTFail("Cart Scene ViewController is not created")
            return
        }
        
        router = viewController.router
        XCTAssertNotNil(router, "Cart Scene Router is not created")
        interactor = viewController.interactor
        XCTAssertNotNil(interactor, "Cart Scene Interactor is not created")
        presenter = (viewController.interactor as? CartSceneInteractor)?.presenter
        XCTAssertNotNil(presenter, "Cart Scene Presenter is not created")
        
        interactor?.showCart()
        XCTAssertEqual(viewController.deliveryValueLabel.text, cartTotal.delivery)
    }

}
