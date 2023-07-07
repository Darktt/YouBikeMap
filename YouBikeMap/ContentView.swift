//
//  ContentView.swift
//  YouBikeMap
//
//  Created by Eden on 2023/7/4.
//

import SwiftUI

public
struct ContentView: View
{
    @EnvironmentObject
    private
    var store: YouBikeStore
    
    public
    var body: some View {
        
        NavigationView {
            
            YouBikeListView(mapItems: self.store.state.mapItems)
            .navigationBarTitle(Text("YouBike"), displayMode: .automatic)
        }
        .onAppear(perform: self.fetch)
    }
    
    func fetch()
    {
        self.store.sendAction(.fetchData)
    }
}

struct ContentView_Previews: PreviewProvider
{
    static var previews: some View
    {
        ContentView()
            .environmentObject(YouBikeStore.default)
    }
}
