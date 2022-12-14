//
//  DetailSceneConfigurator.swift
//  EConcept
//
//  Created by Grigory Stolyarov on 06.12.2022.
//

import Foundation

protocol DetailSceneConfiguratorProtocol {
    
    func configured(product: ProductSmartphone, vc: DetailSceneViewController) -> DetailSceneViewController
}

final class DetailSceneConfigurator: DetailSceneConfiguratorProtocol {
    
    private var sceneFactory: SceneFactory
    
    init(sceneFactory: SceneFactory) {
        self.sceneFactory = sceneFactory
    }
    
    @discardableResult
    func configured(product: ProductSmartphone, vc: DetailSceneViewController) -> DetailSceneViewController {
        
        let interactor = DetailSceneInteractor(product: product)
        let presenter = DetailScenePresenter()
        let router = DetailSceneRouter(sceneFactory: sceneFactory)
        router.source = vc
        presenter.viewController = vc
        interactor.presenter = presenter
        vc.interactor = interactor
        vc.router = router
        return vc
    }
}
