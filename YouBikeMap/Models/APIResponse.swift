//
//  APIResponse.swift
//  YouBikeMap
//
//  Created by Eden on 2023/7/4.
//

import Foundation
import JsonProtection

public
struct APIResponse
{
    // MARK: - Properties -
    
    public private(set)
    var data: Data?
    
    @BoolProtection
    public
    var isSuccessed: Bool?
}

extension APIResponse: JsonDecodable
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
extension APIResponse
{
    // MARK: - Properties -
    
    struct Data
    {
        @NumberProtection
        public
        var returnCode: Int?
        
        public private(set)
        var returnValue: Array<YouBikeMapItem>?
    }
}

extension APIResponse.Data: Decodable
{
    private
    enum CodingKeys: String, CodingKey
    {
        case returnCode = "retCode"
        
        case returnValue = "retVal"
    }
}
