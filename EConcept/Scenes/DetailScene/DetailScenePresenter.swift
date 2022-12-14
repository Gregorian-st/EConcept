//
//  DetailScenePresenter.swift
//  EConcept
//
//  Created by Grigory Stolyarov on 06.12.2022.
//

import UIKit

typealias DetailScenePresenterInput = DetailSceneInteractorOutput
typealias DetailScenePresenterOutput = DetailSceneViewControllerInput

final class DetailScenePresenter {
    
    weak var viewController: DetailScenePresenterOutput?
}

extension DetailScenePresenter: DetailScenePresenterInput {
    
    func showProductDetails(product: ProductSmartphone) {
        
        viewController?.showProductDetails(product: product)
    }
}
