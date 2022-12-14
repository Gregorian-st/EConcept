//
//  FilterSceneRouter.swift
//  EConcept
//
//  Created by Grigory Stolyarov on 13.12.2022.
//

import UIKit

protocol FilterSceneRoutingProtocol {
    
    func closeFilterView()
}

final class FilterSceneRouter {
    
    weak var source: UIViewController?
    
    private let sceneFactory: SceneFactory
    
    init(sceneFactory: SceneFactory) {
        
        self.sceneFactory = sceneFactory
    }
}

extension FilterSceneRouter: FilterSceneRoutingProtocol {
    
    func closeFilterView() {
        
        source?.dismiss(animated: true)
    }
}
