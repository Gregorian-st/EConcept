//
//  CartSceneRouter.swift
//  EConcept
//
//  Created by Grigory Stolyarov on 07.12.2022.
//

import UIKit

protocol CartSceneRoutingProtocol {
    
    func closeCartView()
}

final class CartSceneRouter {
    
    weak var source: UIViewController?
    
    private let sceneFactory: SceneFactory
    
    init(sceneFactory: SceneFactory) {
        
        self.sceneFactory = sceneFactory
    }
}

extension CartSceneRouter: CartSceneRoutingProtocol {
    
    func closeCartView() {
        
        source?.navigationController?.popViewController(animated: true)
    }
}
