//
//  YouBikeStore.swift
//  YouBikeMap
//
//  Created by Eden on 2023/7/4.
//

import Foundation

fileprivate let _reducer: YouBikeStore.Reducer = {
    
    (state, action) in
    
    var state: YouBikeStore.State = state
    var newAction: YouBikeStore.Action? = nil
    
    switch action
    {
        case let .fetchDataResponse(mapItems):
            state.mapItems = mapItems
        
        default:
            break
    }
    
    return (state, newAction)
}

@MainActor
public final
class YouBikeStore: Store
{
    // MARK: - Properties -
    
    public static
    var `default`: YouBikeStore {
        
        YouBikeStore()
    }
    
    @Published
    public
    var state: State = .init()
    
    public
    let reducer: Reducer
    
    public
    let middleware: AnyMiddleware<Action>
    
    private
    init()
    {
        self.middleware = YouBikeMiddleware().eraseToAnyMiddleware()
        self.reducer = _reducer
    }
    
    func sendAction(_ action: Action)
    {
        Task {
            
            let responseAction: Action = try await self.middleware(action: action)
            let result: ReducerResult = self.reducer(self.state, responseAction)
            
            self.state = result.state
            try await self.sendNextAction(result.action)
        }
    }
}

private
extension YouBikeStore
{
    func sendNextAction(_ action: Action?) async throws
    {
        guard let action = action else {
            
            return
        }
        
        self.sendAction(action)
    }
}

// MARK: - YouBikeStore.State -

public
extension YouBikeStore
{
    struct State
    {
        public fileprivate(set)
        var mapItems: Array<YouBikeMapItem> = []
        
        fileprivate
        init() { }
    }
}
