//
//  Store.swift
//  YouBikeMap
//
//  Created by Eden on 2023/7/4.
//

import Foundation
import Combine

public
protocol Store: ObservableObject
{
    associatedtype State
    
    associatedtype Action
    
    typealias ReducerResult = (state: State, action: Action?)
    typealias Reducer = (State, Action) -> ReducerResult
    
    var state: State { get }
    
    var reducer: Reducer { get }
    
    var middleware: AnyMiddleware<Action> { get }
}
