//
//  HomeSceneRouter.swift
//  EConcept
//
//  Created by Grigory Stolyarov on 06.12.2022.
//

import UIKit

protocol HomeSceneRoutingProtocol {
    
    func showMainDataFailure(message: String)
    func showProductDetails(product: ProductSmartphone)
    func showProductDetailsFailure(message: String)
    func showCart(cartTotal: CartTotal)
    func showCartFailure(message: String)
    func showFilterParameters(filterParameters: FilterParameters)
    func showNotImplemented(message: String)
}

final class HomeSceneRouter {
    
    weak var source: UIViewController?
    
    private let sceneFactory: SceneFactory
    
    init(sceneFactory: SceneFactory) {
        
        self.sceneFactory = sceneFactory
    }
}

extension HomeSceneRouter: HomeSceneRoutingProtocol {
    
    func showMainDataFailure(message: String) {
        
        let action = UIAlertAction(title: "OK", style: .destructive)
        let alertController = UIAlertController(title: "Main Data Info Failure",
                                                message: message,
                                                preferredStyle: .alert)
        alertController.addAction(action)
        source?.present(alertController, animated: true)
    }
    
    func showProductDetails(product: ProductSmartphone) {
        
        let configurator = DetailSceneConfigurator(sceneFactory: sceneFactory)
        let scene = sceneFactory.makeDetailScene(product: product, configurator: configurator)
        source?.navigationController?.pushViewController(scene, animated: true)
    }
    
    func showProductDetailsFailure(message: String) {
        
        let action = UIAlertAction(title: "OK", style: .destructive)
        let alertController = UIAlertController(title: "Product Details Info Failure",
                                                message: message,
                                                preferredStyle: .alert)
        alertController.addAction(action)
        source?.present(alertController, animated: true)
    }
    
    func showCart(cartTotal: CartTotal) {
        
        let configurator = CartSceneConfigurator(sceneFactory: sceneFactory)
        let scene = sceneFactory.makeCartScene(cartTotal: cartTotal, configurator: configurator)
        source?.navigationController?.pushViewController(scene, animated: true)
    }
    
    func showCartFailure(message: String) {
        
        let action = UIAlertAction(title: "OK", style: .destructive)
        let alertController = UIAlertController(title: "Cart Info Failure",
                                                message: message,
                                                preferredStyle: .alert)
        alertController.addAction(action)
        source?.present(alertController, animated: true)
    }
    
    func showFilterParameters(filterParameters: FilterParameters) {
        
        let configurator = FilterSceneConfigurator(sceneFactory: sceneFactory)
        let scene = sceneFactory.makeFilterScene(filterParameters: filterParameters, configurator: configurator)
        
        if let sheet = scene.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.preferredCornerRadius = 30
        }
        source?.present(scene, animated: true, completion: nil)
    }
    
    func showNotImplemented(message: String) {
        
        let text = "Hmm, looks like the function\n \(message)\n is not implemented yet.\nBut we are working on it 👷🏻‍♂️"
        let action = UIAlertAction(title: "OK", style: .destructive)
        let alertController = UIAlertController(title: "Under Construction",
                                                message: text,
                                                preferredStyle: .alert)
        alertController.addAction(action)
        source?.present(alertController, animated: true)
    }
}
