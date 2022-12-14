//
//  HomeScenePresenter.swift
//  EConcept
//
//  Created by Grigory Stolyarov on 06.12.2022.
//

import UIKit

typealias HomeScenePresenterInput = HomeSceneInteractorOutput
typealias HomeScenePresenterOutput = HomeSceneViewControllerInput

final class HomeScenePresenter {
    
    weak var viewController: HomeScenePresenterOutput?
}

extension HomeScenePresenter: HomeScenePresenterInput {
    
    func showMainData(homeItems: HomeItems) {
        
        viewController?.showMainData(homeItems: homeItems)
    }
    
    func showMainDataCart(cartTotal: CartTotal) {
        
        viewController?.showMainDataCart(cartTotal: cartTotal)
    }
    
    func showMainDataFailure(message: String) {
        
        viewController?.showMainDataFailure(message: """
            Oops, something failed on our side :(
            \(message)
            """)
    }
    
    func showProductDetails(product: ProductSmartphone) {
        
        viewController?.showProductDetails(product: product)
    }
    
    func showProductDetailsFailure(message: String) {
        
        viewController?.showProductDetailsFailure(message: """
            Oops, can't get Product details :(
            \(message)
            """)
    }
    
    func showCart(cartTotal: CartTotal) {
        
        viewController?.showCart(cartTotal: cartTotal)
    }
    
    func showCartFailure(message: String) {
        
        viewController?.showCartFailure(message: """
            Oops, can't get Cart content :(
            \(message)
            """)
    }
}
