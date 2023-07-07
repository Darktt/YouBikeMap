//
//  JsonDecodable.swift
//  YouBikeMap
//
//  Created by Eden on 2023/7/4.
//

import Foundation

public
protocol JsonDecodable: Decodable
{
    
}

public
extension JsonDecodable
{
    static func decode(with data: Data) throws -> Self
    {
        let jsonDecoder = JSONDecoder()
        let object: Self = try jsonDecoder.decode(Self.self, from: data)
        
        return object
    }
}
