//
//  YouBikeAction.swift
//  YouBikeMap
//
//  Created by Eden on 2023/7/4.
//

import Foundation

public
extension YouBikeStore
{
    enum Action
    {
        case fetchData
        
        case fetchDataResponse(Array<YouBikeMapItem>)
    }
}
