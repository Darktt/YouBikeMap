//
//  YouBikeMapResponse.swift
//  YouBikeMap
//
//  Created by Eden on 2023/10/6.
//

import Foundation
import JsonProtection

public
typealias YouBikeMapItems = Array<YouBikeMapItem>

public
struct YouBikeMapResponse
{
    // MARK: - Properties -
    
    public private(set)
    var data: Data?
    
    @BoolProtection
    public
    var isSuccessed: Bool?
}

extension YouBikeMapResponse: JsonDecodable
{
    private
    enum CodingKeys: String, CodingKey
    {
        case data
        
        case isSuccessed = "success"
    }
}

// MARK: - APIResponse.Data -

public
extension YouBikeMapResponse
{
    // MARK: - Properties -
    
    struct Data
    {
        @NumberProtection
        public
        var returnCode: Int?
        
        public private(set)
        var returnValue: YouBikeMapItems?
    }
}

extension YouBikeMapResponse.Data: Decodable
{
    private
    enum CodingKeys: String, CodingKey
    {
        case returnCode = "retCode"
        
        case returnValue = "retVal"
    }
}
