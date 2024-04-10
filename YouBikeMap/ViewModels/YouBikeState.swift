//
//  YouBikeState.swift
//  YouBikeMap
//
//  Created by Eden on 2024/4/3.
//

import Foundation

public
struct YouBikeState
{
    public
    var mapItems: Array<YouBikeMapItem> = []
    
    public
    var error: YouBikeError?
    
    public
    var privateMapItems: Array<YouBikeMapItem> = []
}
