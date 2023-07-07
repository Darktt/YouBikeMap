//
//  Middleware.swift
//  yunbaolive
//
//  Created by Eden on 2023/3/3.
//  Copyright © 2023 cat. All rights reserved.
//

import Foundation

// MARK: - Middleware -

public
protocol Middleware
{
    associatedtype Action
    
    func callAsFunction(action: Action) async throws -> Action
}

public
extension Middleware
{
    func eraseToAnyMiddleware() -> AnyMiddleware<Action>
    {
        guard let middleware = self as? AnyMiddleware<Action> else {
            
            return AnyMiddleware(self)
        }
        
        return middleware
    }
}

// MARK: - AnyMiddleware -

public
struct AnyMiddleware<Action>: Middleware
{
    // MARK: - Properties -
    
    private
    let wrappedMiddleware: (Action) async throws -> Action
    
    // MARK: - Methods -
    // MARK: Initial Method
    
    fileprivate
    init<M: Middleware>(_ middleware: M) where M.Action == Action
    {
        self.wrappedMiddleware = middleware.callAsFunction
    }
    
    public
    func callAsFunction(action: Action) async throws -> Action
    {
        try await self.wrappedMiddleware(action)
    }
}

// MARK: - MiddlewarePipeline -

public
struct MiddlewarePipeline<Action>: Middleware
{
    private
    let middlewares: Array<AnyMiddleware<Action>>
    
    public
    init(_ middleware: AnyMiddleware<Action>...)
    {
        self.middlewares = middleware
    }
    
    public
    init(_ middlewares: [AnyMiddleware<Action>])
    {
        self.middlewares = middlewares
    }
    
    public
    func callAsFunction(action: Action) async throws -> Action
    {
        try await self.nextMiddleware(action: action)
    }
}

private
extension MiddlewarePipeline
{
    private
    func nextMiddleware(action: Action, index: Int = 0) async throws -> Action
    {
        guard index < self.middlewares.count else {
            
            return action
        }
        
        let nextMiddleware = self.middlewares[index]
        let action: Action = try await nextMiddleware(action: action)
        
        let nextIndex: Int = index + 1
        let nextAction: Action = try await self.nextMiddleware(action: action, index: nextIndex)
        
        return nextAction
    }
}
