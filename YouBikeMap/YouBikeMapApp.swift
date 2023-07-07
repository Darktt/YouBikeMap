//
//  YouBikeMapApp.swift
//  YouBikeMap
//
//  Created by Eden on 2023/7/4.
//

import SwiftUI

@main
struct YouBikeMapApp: App
{
    var body: some Scene {
        
        WindowGroup {
            
            ContentView()
                .environmentObject(YouBikeStore.default)
        }
    }
}
