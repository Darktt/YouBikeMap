//
//  YouBikeMiddleware.swift
//  YouBikeMap
//
//  Created by Eden on 2023/7/4.
//

import Foundation

public
struct YouBikeMiddleware: Middleware
{
    public
    typealias Action = YouBikeStore.Action
    
    // MARK: - Methods -
    // MARK: Initial Method
    
    public
    func callAsFunction(action: Action) async throws -> Action
    {
        let nextAction: Action
        
        switch action {
            
            case .fetchData:
            nextAction = try await self.fetchDataAction(action)
            
            default:
                nextAction = action
        }
        
        return nextAction
    }
}

private
extension YouBikeMiddleware
{
    func fetchDataAction(_ action: Action) async throws -> Action
    {
        let apiHandler = APIHandler.shared
        let response: APIResponse = try await apiHandler.sendRequest(via: .bikeMap)
        let mapItems: Array<YouBikeMapItem> = response.data?.returnValue ?? []
        
        return .fetchDataResponse(mapItems)
    }
}
