//
//  SearchMiddware.swift
//  YouBikeMap
//
//  Created by Eden on 2024/4/10.
//

import Foundation

@MainActor
public
let SearchMiddware: Middleware<YouBikeState, YouBikeAction> = {
    
    store in
    
    {
        next in
        
        {
            action in
            
            if case YouBikeAction.search(let keyword) = action {
                
                var mapItems = store.state.privateMapItems
                
                if !keyword.isEmpty {
                    
                    mapItems.filtered {
                        
                        $0.name.contains(keyword)
                    }
                }
                
                let newAction = YouBikeAction.searchResult(mapItems)
                
                next(newAction)
                return
            }
            
            next(action)
        }
    }
}
