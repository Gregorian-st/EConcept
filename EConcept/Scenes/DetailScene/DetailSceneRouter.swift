//
//  DetailSceneRouter.swift
//  EConcept
//
//  Created by Grigory Stolyarov on 06.12.2022.
//

import UIKit

protocol DetailSceneRoutingProtocol {
    
    func closeDetailView()
}

final class DetailSceneRouter {
    
    weak var source: UIViewController?
    
    private let sceneFactory: SceneFactory
    
    init(sceneFactory: SceneFactory) {
        
        self.sceneFactory = sceneFactory
    }
}

extension DetailSceneRouter: DetailSceneRoutingProtocol {
    
    func closeDetailView() {
        
        source?.navigationController?.popViewController(animated: true)
    }
}
