//
//  DetailSceneInteractor.swift
//  EConcept
//
//  Created by Grigory Stolyarov on 06.12.2022.
//

import Foundation

typealias DetailSceneInteractorInput = DetailSceneViewControllerOutput

protocol DetailSceneInteractorOutput: AnyObject {
    
    func showProductDetails(product: ProductSmartphone)
}

final class DetailSceneInteractor {
    
    var presenter: DetailScenePresenterInput?
    
    private var product: ProductSmartphone?
    
    init(product: ProductSmartphone) {
        self.product = product
    }
}

extension DetailSceneInteractor: DetailSceneInteractorInput {
    
    func showProductDetails() {
        
        guard let product = product
        else { return }
        presenter?.showProductDetails(product: product)
    }
    
    func addToCart(product: ProductSmartphone) {
        
        print(#function)
    }
}
