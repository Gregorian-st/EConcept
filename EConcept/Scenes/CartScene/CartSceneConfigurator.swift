//
//  CartSceneConfigurator.swift
//  EConcept
//
//  Created by Grigory Stolyarov on 07.12.2022.
//

import Foundation

protocol CartSceneConfiguratorProtocol {
    
    func configured(cartTotal: CartTotal, vc: CartSceneViewController) -> CartSceneViewController
}

final class CartSceneConfigurator: CartSceneConfiguratorProtocol {
    
    private var sceneFactory: SceneFactory
    
    init(sceneFactory: SceneFactory) {
        self.sceneFactory = sceneFactory
    }
    
    @discardableResult
    func configured(cartTotal: CartTotal, vc: CartSceneViewController) -> CartSceneViewController {
        
        let interactor = CartSceneInteractor(cartTotal: cartTotal)
        let presenter = CartScenePresenter()
        let router = CartSceneRouter(sceneFactory: sceneFactory)
        router.source = vc
        presenter.viewController = vc
        interactor.presenter = presenter
        vc.interactor = interactor
        vc.router = router
        return vc
    }
}
