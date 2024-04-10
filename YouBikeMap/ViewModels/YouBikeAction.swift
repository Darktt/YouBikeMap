//
//  YouBikeAction.swift
//  YouBikeMap
//
//  Created by Eden on 2023/7/4.
//

import Foundation

public
enum YouBikeAction
{
    case fetchData
    
    case fetchDataResponse(Array<YouBikeMapItem>)
    
    case fetchDataError(Error)
    
    case error(YouBikeError)
    
    case search(String)
    
    case searchResult(Array<YouBikeMapItem>)
}
