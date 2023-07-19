//
//  Store.swift
//  YouBikeMap
//
//  Created by Eden on 2023/7/4.
//

import Foundation
import Combine

@MainActor
public final
class Store<State, Action, Context>: ObservableObject
{
    public
    typealias Reducer = (State, Action, Context) async throws -> State
    
    @Published
    public private(set)
    var state: State
    
    public private(set)
    var context: Context
    
    private(set)
    var reducer: Reducer
    
    public
    init(state: State, context: Context, reducer: @escaping Reducer)
    {
        self.state = state
        self.context = context
        self.reducer = reducer
    }
    
    public
    func send(_ action: Action) throws
    {
        Task {
            
            let state = try await self.reducer(self.state, action, self.context)
            
            self.state = state
        }
    }
}
