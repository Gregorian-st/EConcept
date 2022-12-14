//
//  HomeSceneNetWorker.swift
//  EConcept
//
//  Created by Grigory Stolyarov on 05.12.2022.
//

import Foundation

protocol HomeSceneNetWorkerProtocol {
    
    func getMain(completion: @escaping (Result<HomeItems, HomeSceneNetWorker.HomeSceneNetWorkerError>) -> Void)
    func getProduct(completion: @escaping (Result<ProductSmartphone, HomeSceneNetWorker.HomeSceneNetWorkerError>) -> Void)
    func getCart(completion: @escaping (Result<CartTotal, HomeSceneNetWorker.HomeSceneNetWorkerError>) -> Void)
}

final class HomeSceneNetWorker {
    
    enum HomeSceneNetWorkerError: Error {
        case requestFailed(String)
    }
    
    private let requestFactory = RequestFactory()
}

extension HomeSceneNetWorker: HomeSceneNetWorkerProtocol {
    
    func getMain(completion: @escaping (Result<HomeItems, HomeSceneNetWorker.HomeSceneNetWorkerError>) -> Void) {
        
        let requestAPIEConcept = requestFactory.makeAPIEConceptRequestFactory()
        
        requestAPIEConcept.getMain { response in
            switch response.result {
            case .success(let result):
                var homeItems = HomeItems()
                homeItems.homeStoreItems = result.homeStoreItems
                homeItems.bestSellerItems = result.bestSellerItems
                completion(.success(homeItems))
            case .failure(let error):
                completion(.failure(.requestFailed(error.localizedDescription)))
            }
        }
    }
    
    func getProduct(completion: @escaping (Result<ProductSmartphone, HomeSceneNetWorker.HomeSceneNetWorkerError>) -> Void) {
        
        let requestAPIEConcept = requestFactory.makeAPIEConceptRequestFactory()
        
        requestAPIEConcept.getProductSmartphone { response in
            switch response.result {
            case .success(let result):
                var productSmartphone = ProductSmartphone()
                productSmartphone = result.productSmartphone
                completion(.success(productSmartphone))
            case .failure(let error):
                completion(.failure(.requestFailed(error.localizedDescription)))
            }
        }
    }
    
    func getCart(completion: @escaping (Result<CartTotal, HomeSceneNetWorker.HomeSceneNetWorkerError>) -> Void) {
        
        let requestAPIEConcept = requestFactory.makeAPIEConceptRequestFactory()
        
        requestAPIEConcept.getCart { response in
            switch response.result {
            case .success(let result):
                var cartTotal = CartTotal()
                cartTotal = result.cartTotal
                completion(.success(cartTotal))
            case .failure(let error):
                completion(.failure(.requestFailed(error.localizedDescription)))
            }
        }
    }
}
