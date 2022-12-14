//
//  FilterSceneConfigurator.swift
//  EConcept
//
//  Created by Grigory Stolyarov on 13.12.2022.
//

import Foundation

protocol FilterSceneConfiguratorProtocol {
    
    func configured(filterParameters: FilterParameters, vc: FilterSceneViewController) -> FilterSceneViewController
}

final class FilterSceneConfigurator: FilterSceneConfiguratorProtocol {
    
    private var sceneFactory: SceneFactory
    
    init(sceneFactory: SceneFactory) {
        self.sceneFactory = sceneFactory
    }
    
    @discardableResult
    func configured(filterParameters: FilterParameters, vc: FilterSceneViewController) -> FilterSceneViewController {
        
        let interactor = FilterSceneInteractor(filterParameters: filterParameters)
        let presenter = FilterScenePresenter()
        let router = FilterSceneRouter(sceneFactory: sceneFactory)
        router.source = vc
        presenter.viewController = vc
        interactor.presenter = presenter
        vc.interactor = interactor
        vc.router = router
        return vc
    }
}
