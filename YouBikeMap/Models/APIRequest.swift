//
//  APIRequest.swift
//
//  Created by Darktt on 2023/10/6.
//

import Foundation
import SwiftExtensions

public
protocol APIRequest
{
    associatedtype Response: JsonDecodable
    
    typealias Result = Swift.Result<Response, any Error>
    
    // MARK: - Properties -
    
    var apiName: APIName { get }
    
    var method: HTTPMethod { get }
    
    var parameters: Dictionary<AnyHashable, Any>? { get }
    
    var headers: Array<HTTPHeader>? { get }
}

extension APIRequest
{
    var urlRequest: URLRequest {
        
        let url = self.apiName.url
        var request = URLRequest(url: url)
        request.method = self.method
        request.allHTTPHeaderFields = self.headers?.dictionary()
        
        return request
    }
}
