//
//  ErrorParser.swift
//  EConcept
//
//  Created by Grigory Stolyarov on 05.12.2022.
//

import Foundation

protocol AbstractErrorParserProtocol {
    
    func parse(_ result: Error) -> Error
    func parse(response: HTTPURLResponse?, data: Data?, error: Error?) -> Error?
}

final class ErrorParser: AbstractErrorParserProtocol {
    
    func parse(_ result: Error) -> Error {
        
        return result
    }
    
    func parse(response: HTTPURLResponse?, data: Data?, error: Error?) -> Error? {
        
        return error
    }
    
}
