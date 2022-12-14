//
//  RequestFactory.swift
//  EConcept
//
//  Created by Grigory Stolyarov on 05.12.2022.
//

import Foundation
import Alamofire

final class RequestFactory {
    
    func makeErrorParser() -> AbstractErrorParserProtocol {
        
        return ErrorParser()
    }
    
    lazy var commonSession: Session = {
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default
        let manager = Session(configuration: configuration)
        return manager
    }()
    
    let sessionQueue = DispatchQueue.global(qos: .utility)
    
    func makeAPIEConceptRequestFactory() -> APIEConceptRequestFactoryProtocol {
        
        let errorParser = makeErrorParser()
        return APIEConcept(errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue)
    }
}
