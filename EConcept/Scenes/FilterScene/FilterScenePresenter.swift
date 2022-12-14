//
//  FilterScenePresenter.swift
//  EConcept
//
//  Created by Grigory Stolyarov on 13.12.2022.
//

import UIKit

typealias FilterScenePresenterInput = FilterSceneInteractorOutput
typealias FilterScenePresenterOutput = FilterSceneViewControllerInput

final class FilterScenePresenter {
    
    weak var viewController: FilterScenePresenterOutput?
}

extension FilterScenePresenter: FilterScenePresenterInput {
    
    func showFilterParameters(filterParameters: FilterParameters) {
        
        viewController?.showFilterParameters(filterParameters: filterParameters)
    }
}
