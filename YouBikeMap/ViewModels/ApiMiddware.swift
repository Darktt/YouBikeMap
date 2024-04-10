//
//  ApiMiddware.swift
//  YouBikeMap
//
//  Created by Eden on 2024/3/1.
//

import Foundation

@MainActor
public
let ApiMiddware: Middleware<YouBikeState, YouBikeAction> = {
    
    store in
    
    {
        next in
        
        {
            action in
            
            if case YouBikeAction.fetchData = action {
                
                Task {
                    
                    do {
                        
                        let apiHandler = APIHandler.shared
                        let response: YouBikeMapResponse = try await apiHandler.sendRequest(YouBikeMapRequest())
                        let mapItems: Array<YouBikeMapItem> = response.data?.returnValue ?? []
                        
                        let newAction = YouBikeAction.fetchDataResponse(mapItems)
                        
                        next(newAction)
                    } catch {
                        
                        let newAction = YouBikeAction.fetchDataError(error)
                        
                        next(newAction)
                    }
                }
                return
            }
            
            next(action)
        }
    }
}
