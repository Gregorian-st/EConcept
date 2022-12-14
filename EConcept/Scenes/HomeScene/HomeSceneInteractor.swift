//
//  HomeSceneInteractor.swift
//  EConcept
//
//  Created by Grigory Stolyarov on 05.12.2022.
//

import Foundation

typealias HomeSceneInteractorInput = HomeSceneViewControllerOutput

protocol HomeSceneInteractorOutput: AnyObject {
    
    func showMainData(homeItems: HomeItems)
    func showMainDataCart(cartTotal: CartTotal)
    func showMainDataFailure(message: String)
    func showProductDetails(product: ProductSmartphone)
    func showProductDetailsFailure(message: String)
    func showCart(cartTotal: CartTotal)
    func showCartFailure(message: String)
}

final class HomeSceneInteractor {
    
    var presenter: HomeScenePresenterInput?
    var netWorker: HomeSceneNetWorkerProtocol?
}

extension HomeSceneInteractor: HomeSceneInteractorInput {
    
    func getMainData() {
        
        netWorker?.getMain { result in
            DispatchQueue.main.async { [weak self] in
                switch result {
                case .success(let homeItems):
                    self?.presenter?.showMainData(homeItems: homeItems)
                case .failure(let error):
                    self?.presenter?.showMainDataFailure(message: error.localizedDescription)
                }
            }
        }
        
        netWorker?.getCart { result in
            DispatchQueue.main.async { [weak self] in
                switch result {
                case .success(let cartTotal):
                    self?.presenter?.showMainDataCart(cartTotal: cartTotal)
                case .failure(let error):
                    self?.presenter?.showCartFailure(message: error.localizedDescription)
                }
            }
        }
    }
    
    func getProductDetails() {
        
        netWorker?.getProduct { result in
            DispatchQueue.main.async { [weak self] in
                switch result {
                case .success(let productSmartphone):
                    self?.presenter?.showProductDetails(product: productSmartphone)
                case .failure(let error):
                    self?.presenter?.showProductDetailsFailure(message: error.localizedDescription)
                }
            }
        }
    }
    
    func getCart() {
        
        netWorker?.getCart { result in
            DispatchQueue.main.async { [weak self] in
                switch result {
                case .success(let cartTotal):
                    self?.presenter?.showCart(cartTotal: cartTotal)
                case .failure(let error):
                    self?.presenter?.showCartFailure(message: error.localizedDescription)
                }
            }
        }
    }
}
