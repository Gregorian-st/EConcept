//
//  FilterSceneInteractor.swift
//  EConcept
//
//  Created by Grigory Stolyarov on 13.12.2022.
//

import Foundation

typealias FilterSceneInteractorInput = FilterSceneViewControllerOutput

protocol FilterSceneInteractorOutput: AnyObject {
    
    func showFilterParameters(filterParameters: FilterParameters)
}

final class FilterSceneInteractor {
    
    var presenter: FilterScenePresenterInput?
    
    private var filterParameters: FilterParameters?
    
    init(filterParameters: FilterParameters) {
        self.filterParameters = filterParameters
    }
}

extension FilterSceneInteractor: FilterSceneInteractorInput {
    
    func showFilterParameters() {
        
        guard let filterParameters = filterParameters
        else { return }
        presenter?.showFilterParameters(filterParameters: filterParameters)
    }    
}
