//
//  ErrorMiddware.swift
//  YouBikeMap
//
//  Created by Eden on 2024/4/3.
//

import Foundation

@MainActor
public
let ErrorMiddware: Middleware<YouBikeState, YouBikeAction> = {
    
    store in 
    
    {
        next in 
        
        {
            action in
            
            if case YouBikeAction.fetchDataError(let error) = action,
                let error = error as? CustomNSError {
                
                let error = YouBikeError(code: error.errorCode, message: error.localizedDescription)
                let newAction = YouBikeAction.error(error)
                
                next(newAction)
                return
            }
            
            next(action)
        }
    }
}
