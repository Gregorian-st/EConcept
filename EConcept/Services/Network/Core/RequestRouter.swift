//
//  RequestRouter.swift
//  EConcept
//
//  Created by Grigory Stolyarov on 05.12.2022.
//

import Foundation
import Alamofire

enum RequestRouterEncoding {
    case url, json
}

protocol RequestRouterProtocol: URLRequestConvertible {

    var baseUrl: String { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: Parameters? { get }
    var fullUrl: URL { get }
    var encoding: RequestRouterEncoding { get }

}

extension RequestRouterProtocol {

    var fullUrl: URL {
        if let url = URL(string: baseUrl) {
            return url.appendingPathComponent(path)
        } else {
            let url = URL(string: "http://127.0.0.1")!
            return url.appendingPathComponent(path)
        }
    }

    var encoding: RequestRouterEncoding {
        return .url
    }

    func asURLRequest() throws -> URLRequest {
        
        var urlRequest = URLRequest(url: fullUrl)
        
        urlRequest.httpMethod = method.rawValue
        
        switch self.encoding {
        case .url:
            return try URLEncoding.default.encode(urlRequest, with: parameters)
        case .json:
            return try JSONEncoding.default.encode(urlRequest, with: parameters)
        }
    }
}
