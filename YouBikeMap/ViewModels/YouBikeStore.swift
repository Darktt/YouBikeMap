//
//  YouBikeStore.swift
//  YouBikeMap
//
//  Created by Eden on 2023/7/4.
//

private
func kReducer(state: YouBikeState, action: YouBikeAction) -> YouBikeState {
    
    print("進入　　　 Reducer        : 動作：\(action) 狀態：\(state)")
    
    var newState = state
    newState.error = nil
    
    switch action {
        
        case .fetchDataResponse(let mapItems):
            newState.mapItems = mapItems
        
        case .error(let error):
            newState.error = error
        
        default:
            break
    }
    
    print("離開　　　 Reducer        : 動作：\(action), 狀態：\(newState)")
    return newState
}

let youBikeStore = Store(initialState: YouBikeState(), reducer: kReducer, middlewares: [ApiMiddware, ErrorMiddware])
