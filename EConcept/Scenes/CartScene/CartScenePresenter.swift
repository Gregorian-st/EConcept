//
//  CartScenePresenter.swift
//  EConcept
//
//  Created by Grigory Stolyarov on 07.12.2022.
//

import UIKit

typealias CartScenePresenterInput = CartSceneInteractorOutput
typealias CartScenePresenterOutput = CartSceneViewControllerInput

final class CartScenePresenter {
    
    weak var viewController: CartScenePresenterOutput?
}

extension CartScenePresenter: CartScenePresenterInput {
    
    func showCart(cartTotal: CartTotal) {
        
        viewController?.showCart(cartTotal: cartTotal)
    }
}
