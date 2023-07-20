//
//  YouBikeStore.swift
//  YouBikeMap
//
//  Created by Eden on 2023/7/4.
//

import Foundation

public
typealias YouBikeStore = Store<YouBikeState, YouBikeAction, YouBikeContext>

@MainActor
let kYouBikeStore = YouBikeStore(state: YouBikeState(), context: YouBikeContext(), reducer: _reducer)

// MARK: - YouBikeState -

public
struct YouBikeState
{
    public fileprivate(set)
    var mapItems: Array<YouBikeMapItem> = []
    
    fileprivate
    var privateMapItems: Array<YouBikeMapItem> = []
    
    fileprivate
    init() { }
}

// MARK: - YouBikeContext -

public
struct YouBikeContext
{
    func fetchData() async throws -> Array<YouBikeMapItem>
    {
        let apiHandler = APIHandler.shared
        let response: APIResponse = try await apiHandler.sendRequest(via: .bikeMap)
        let mapItems: Array<YouBikeMapItem> = response.data?.returnValue ?? []
        
        return mapItems
    }
}

// MARK: - Reducer -

fileprivate let _reducer: YouBikeStore.Reducer = {
    
    (state, action, context) in
    
    var state: YouBikeState = state
    
    switch action
    {
        case .fetchData:
            let mapItems = try await context.fetchData()
            state.mapItems = mapItems
            state.privateMapItems = mapItems
        
        case let .search(keyword):
            guard !keyword.isEmpty else {
                
                state.mapItems = state.privateMapItems
                break
            }
            let searchResultItems = state.privateMapItems.filter({ $0.name?.contains(keyword) == true })
            state.mapItems = searchResultItems
        
        default:
            break
    }
    
    return state
}
