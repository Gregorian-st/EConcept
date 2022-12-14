//
//  FilterSceneTests.swift
//  EConceptTests
//
//  Created by Grigory Stolyarov on 14.12.2022.
//

import XCTest
@testable import EConcept

final class FilterSceneTests: XCTestCase {
    
    private var configurator: FilterSceneConfigurator?
    private var viewController: FilterSceneViewController?
    private var router: FilterSceneRoutingProtocol?
    private var interactor: FilterSceneInteractorInput?
    private var presenter: FilterScenePresenterInput?
    
    private var filterParameters = FilterParameters()
    
    override func setUpWithError() throws {
        
        filterParameters = FilterParameters(
            brand: [BrandFilterParameters(id: 55, name: "Foo")],
            price: [PriceFilterParameters(id: 11, minPrice: 555, maxPrice: 666)],
            size: [SizeFilterParameters(id: 777, minSize: 45, maxSize: 102)]
        )
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
        
        configurator = FilterSceneConfigurator(sceneFactory: sceneFactory)
        guard let configurator = configurator else {
            XCTFail("Filter Scene Configurator is not created")
            return
        }

        viewController = sceneFactory.makeFilterScene(filterParameters: filterParameters, configurator: configurator) as? FilterSceneViewController
        guard let viewController = viewController else {
            XCTFail("Filter Scene ViewController is not created")
            return
        }
        
        router = viewController.router
        XCTAssertNotNil(router, "Filter Scene Router is not created")
        interactor = viewController.interactor
        XCTAssertNotNil(interactor, "Filter Scene Interactor is not created")
        presenter = (viewController.interactor as? FilterSceneInteractor)?.presenter
        XCTAssertNotNil(presenter, "Filter Scene Presenter is not created")
        
        interactor?.showFilterParameters()
        XCTAssertEqual(viewController.brandLabel.text, filterParameters.brand[0].description)
        XCTAssertEqual(viewController.priceLabel.text, filterParameters.price[0].description)
        XCTAssertEqual(viewController.sizeLabel.text, filterParameters.size[0].description)
    }

}
