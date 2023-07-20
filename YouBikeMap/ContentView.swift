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
    
    @State
    private
    var searchKeyword: String = ""
    
    public
    var body: some View {
        
        NavigationStack {
            
            YouBikeListView(mapItems: self.store.state.mapItems)
            .navigationBarTitle(Text("YouBike"), displayMode: .automatic)
        }
        .onAppear(perform: self.fetch)
        .searchable(text: self.$searchKeyword)
        .onChange(of: self.searchKeyword) { newValue in
            
            self.search(with: newValue)
        }
    }
    
    func fetch()
    {
        do {
            
            try self.store.send(.fetchData)
        } catch {
            
            print(error)
        }
    }
    
    func search(with keyword: String)
    {
        do {
            
            try self.store.send(.search(keyword))
        } catch {
            
            print(error)
        }
    }
}

struct ContentView_Previews: PreviewProvider
{
    static var previews: some View
    {
        ContentView()
            .environmentObject(kYouBikeStore)
    }
}
