//
//  CartSceneInteractor.swift
//  EConcept
//
//  Created by Grigory Stolyarov on 07.12.2022.
//

import Foundation

typealias CartSceneInteractorInput = CartSceneViewControllerOutput

protocol CartSceneInteractorOutput: AnyObject {
    
    func showCart(cartTotal: CartTotal)
}

final class CartSceneInteractor {
    
    var presenter: CartScenePresenterInput?
    
    private var cartTotal: CartTotal?
    
    init(cartTotal: CartTotal) {
        self.cartTotal = cartTotal
    }
}

extension CartSceneInteractor: CartSceneInteractorInput {
    
    func showCart() {
        
        guard let cartTotal = cartTotal
        else { return }
        presenter?.showCart(cartTotal: cartTotal)
    }
}
