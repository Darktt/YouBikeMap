//
//  APIHandler.swift
//  YouBikeMap
//
//  Created by Eden on 2023/7/4.
//

import Foundation
import SwiftExtensions

public
class APIHandler
{
    // MARK: - Properties -
    
    public static var shared: APIHandler = .init()
    
    private lazy var urlSession: URLSession = {
        
        let configuration = URLSessionConfiguration.ephemeral
        let urlSession = URLSession(configuration: configuration, delegate: nil, delegateQueue: .main)
        
        return urlSession
    }()
    
    // MARK: - Methods -
    // MARK: Initial Method
    
    private
    init()
    {
        
    }
    
    deinit
    {
        
    }
    
    public
    func sendRequest<ResponseObject>(via apiName: APIName) async throws -> ResponseObject where ResponseObject: JsonDecodable
    {
        let response: (Data, URLResponse) = try await self.urlSession.data(from: apiName.url)
        
        if let response = response.1 as? HTTPURLResponse,
            let statusCode = HTTPError.StatusCode(rawValue: response.statusCode) {
            
            throw HTTPError(statusCode)
        }
        
        let responseObject = try ResponseObject.decode(with: response.0)
        
        return responseObject
    }
    
    public
    func sendRequest<ResponseObject>(via apiName: APIName, completion: @escaping (Result<ResponseObject, any Error>) -> Void) where ResponseObject: JsonDecodable
    {
        let handler: URLSession.DataTaskResultHandler = {
            
            [unowned self] result in
            
            self.urlSession.finishTasksAndInvalidate()
            
            let newResult: Result<ResponseObject, Error> = result.flatMap {
                
                data in
                
                Result {
                    
                    try ResponseObject.decode(with: data)
                }
            }
            
            completion(newResult)
        }
        
        let dataTask: URLSessionDataTask = self.urlSession.dataTask(with: apiName.url, completionHandler: handler)
        
        dataTask.resume()
    }
}

private
extension APIHandler
{
    func logJsonString(_ data: Data?)
    {
        guard let data = data else {
            
            return
        }
        
        let jsonString: String = data.string(encoding: .utf8) ?? ""
        
        print(jsonString)
    }
}
