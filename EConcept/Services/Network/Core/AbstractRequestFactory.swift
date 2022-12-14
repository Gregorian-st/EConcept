//
//  AbstractRequestFactory.swift
//  EConcept
//
//  Created by Grigory Stolyarov on 05.12.2022.
//

import Foundation
import Alamofire

typealias FileDescription = (data: Data, name: String, fileName: String, mimeType: String)

protocol AbstractRequestFactoryProtocol {
    
    var errorParser: AbstractErrorParserProtocol { get }
    var sessionManager: Session { get }
    var queue: DispatchQueue { get }
    
    @discardableResult
    func request<T: Decodable>(request: URLRequestConvertible,
                               completionHandler: @escaping (AFDataResponse<T>) -> Void) -> DataRequest
    @discardableResult
    func upload<T: Decodable>(request: URLRequestConvertible,
                              requestParameters: Parameters?,
                              bodyParameters: Parameters,
                              file: FileDescription?,
                              completionHandler: @escaping (AFDataResponse<T>) -> Void) -> DataRequest
    
}

extension AbstractRequestFactoryProtocol {
    
    @discardableResult
    public func request<T: Decodable>(request: URLRequestConvertible,
                                      completionHandler: @escaping (AFDataResponse<T>) -> Void) -> DataRequest {
        
        return sessionManager.request(request)
                    .responseCodable(errorParser: errorParser, queue: queue, completionHandler: completionHandler)
    }
    
    @discardableResult
    public func upload<T: Decodable>(request: URLRequestConvertible,
                                     requestParameters: Parameters?,
                                     bodyParameters: Parameters,
                                     file: FileDescription? = nil,
                                     completionHandler: @escaping (AFDataResponse<T>) -> Void) -> DataRequest {
        
        if let file = file,
           let requestParameters = requestParameters,
           let path: String = request.urlRequest?.url?.absoluteString {
            var fullPath = path + "?"
            for (key, value) in requestParameters {
                fullPath.append("\(key)=\(value)&")
            }
            fullPath.removeLast()
            return sessionManager.upload(multipartFormData: { (multipartFormData) in
                for (key, value) in bodyParameters {
                    guard let value = "\(value)".data(using: String.Encoding.utf8) else {continue}
                    multipartFormData.append(value, withName: key)
                }
                multipartFormData.append(file.data, withName: file.name, fileName: file.fileName, mimeType: file.mimeType)
            },
                                         to: fullPath)
            .responseCodable(errorParser: errorParser, queue: queue, completionHandler: completionHandler)
        } else {
            return sessionManager.request(request)
                        .responseCodable(errorParser: errorParser, queue: queue, completionHandler: completionHandler)
        }
    }
    
}
