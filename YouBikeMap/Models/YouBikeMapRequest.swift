//
//  YouBikeMapRequest.swift
//  YouBikeMap
//
//  Created by Eden on 2023/10/6.
//

import Foundation
import SwiftExtensions

public
struct YouBikeMapRequest: APIRequest
{
    public
    typealias Response = YouBikeMapResponse
    
    // MARK: - Properties -
    
    public
    var apiName: APIName = .bikeMap
    
    public 
    var method: HTTPMethod = .get
    
    public 
    var parameters: Dictionary<AnyHashable, Any>? = nil
    
    public 
    var headers: Array<SwiftExtensions.HTTPHeader>? = nil
}
