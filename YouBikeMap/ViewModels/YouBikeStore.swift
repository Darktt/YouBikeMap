//
//  YouBikeStore.swift
//  YouBikeMap
//
//  Created by Eden on 2023/7/4.
//

@MainActor
private
func kReducer(state: YouBikeState, action: YouBikeAction) -> YouBikeState {
    
    var newState = state
    newState.error = nil
    
    switch action {
        
        case .fetchDataResponse(let mapItems):
            newState.mapItems = mapItems
            newState.privateMapItems = mapItems
        
        case .error(let error):
            newState.error = error
        
        case .searchResult(let mapItems):
            newState.mapItems = mapItems
        
        default:
            break
    }
    
    return newState
}

public
typealias YouBikeStore = Store<YouBikeState, YouBikeAction>

@MainActor
let kYouBikeStore: YouBikeStore = Store(initialState: YouBikeState(), reducer: kReducer, middlewares: [ApiMiddware, ErrorMiddware, SearchMiddware])
