//
//  APIEconceptRequestFactory.swift
//  EConcept
//
//  Created by Grigory Stolyarov on 05.12.2022.
//

import Foundation
import Alamofire

protocol APIEConceptRequestFactoryProtocol {
    
    func getMain(completionHandler: @escaping (AFDataResponse<APIEConceptMainResult>) -> Void)
    func getProductSmartphone(completionHandler: @escaping (AFDataResponse<APIEConceptProductSmartphoneResult>) -> Void)
    func getCart(completionHandler: @escaping (AFDataResponse<APIEConceptCartResult>) -> Void)
}

final class APIEConcept: AbstractRequestFactoryProtocol {
    
    let errorParser: AbstractErrorParserProtocol
    let sessionManager: Session
    let queue: DispatchQueue
    let baseUrl = "https://run.mocky.io/v3/"
    
    init(errorParser: AbstractErrorParserProtocol,
         sessionManager: Session,
         queue: DispatchQueue = DispatchQueue.global(qos: .utility)) {
        
        self.errorParser = errorParser
        self.sessionManager = sessionManager
        self.queue = queue
    }
}

extension APIEConcept: APIEConceptRequestFactoryProtocol {
    
    func getMain(completionHandler: @escaping (AFDataResponse<APIEConceptMainResult>) -> Void) {
        
        let requestModel = GetMain(baseUrl: baseUrl)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func getProductSmartphone(completionHandler: @escaping (AFDataResponse<APIEConceptProductSmartphoneResult>) -> Void) {
        
        let requestModel = GetProductSmartphone(baseUrl: baseUrl)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func getCart(completionHandler: @escaping (AFDataResponse<APIEConceptCartResult>) -> Void) {
        
        let requestModel = GetCart(baseUrl: baseUrl)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

extension APIEConcept {
    
    struct GetMain: RequestRouterProtocol {
        
        let baseUrl: String
        let method: HTTPMethod = .get
        let path: String = "654bd15e-b121-49ba-a588-960956b15175"
        
        var parameters: Parameters? {
            return [:]
        }
    }
    
    struct GetProductSmartphone: RequestRouterProtocol {
        
        let baseUrl: String
        let method: HTTPMethod = .get
        let path: String = "6c14c560-15c6-4248-b9d2-b4508df7d4f5"
        
        var parameters: Parameters? {
            return [:]
        }
    }
    
    struct GetCart: RequestRouterProtocol {
        
        let baseUrl: String
        let method: HTTPMethod = .get
        let path: String = "53539a72-3c5f-4f30-bbb1-6ca10d42c149"
        
        var parameters: Parameters? {
            return [:]
        }
    }
}
