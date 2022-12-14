//
//  HomeSceneConfigurator.swift
//  EConcept
//
//  Created by Grigory Stolyarov on 06.12.2022.
//

import Foundation

protocol HomeSceneConfiguratorProtocol {
    
    func configured(_ vc: HomeSceneViewController) -> HomeSceneViewController
}

final class HomeSceneConfigurator: HomeSceneConfiguratorProtocol {
    
    private var sceneFactory: SceneFactory
    
    init(sceneFactory: SceneFactory) {
        self.sceneFactory = sceneFactory
    }
    
    @discardableResult
    func configured(_ vc: HomeSceneViewController) -> HomeSceneViewController {
        
        let netWorker = HomeSceneNetWorker()
        let interactor = HomeSceneInteractor()
        let presenter = HomeScenePresenter()
        let router = HomeSceneRouter(sceneFactory: sceneFactory)
        router.source = vc
        presenter.viewController = vc
        interactor.presenter = presenter
        interactor.netWorker = netWorker
        vc.interactor = interactor
        vc.router = router
        return vc
    }
}
