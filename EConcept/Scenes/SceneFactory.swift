//
//  SceneFactory.swift
//  EConcept
//
//  Created by Grigory Stolyarov on 06.12.2022.
//

import UIKit

protocol SceneFactory {
    
    func makeHomeScene(configurator: HomeSceneConfigurator) -> UIViewController
    func makeFilterScene(filterParameters: FilterParameters, configurator: FilterSceneConfigurator) -> UIViewController
    func makeDetailScene(product: ProductSmartphone, configurator: DetailSceneConfigurator) -> UIViewController
    func makeCartScene(cartTotal: CartTotal, configurator: CartSceneConfigurator) -> UIViewController
}

final class DefaultSceneFactory: SceneFactory {
    
    func makeHomeScene(configurator: HomeSceneConfigurator) -> UIViewController {
        
        let vc = HomeSceneViewController()
        return configurator.configured(vc)
    }
    
    func makeFilterScene(filterParameters: FilterParameters, configurator: FilterSceneConfigurator) -> UIViewController {
        
        let vc = FilterSceneViewController()
        return configurator.configured(filterParameters: filterParameters, vc: vc)
    }
    
    func makeDetailScene(product: ProductSmartphone, configurator: DetailSceneConfigurator) -> UIViewController {

        let vc = DetailSceneViewController()
        return configurator.configured(product: product, vc: vc)
    }
    
    func makeCartScene(cartTotal: CartTotal, configurator: CartSceneConfigurator) -> UIViewController {

        let vc = CartSceneViewController()
        return configurator.configured(cartTotal: cartTotal, vc: vc)
    }
}
