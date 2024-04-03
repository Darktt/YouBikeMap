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
    
    @State
    private
    var error: Error?
    
    public
    var body: some View {
        
        NavigationStack {
            
            YouBikeListView(mapItems: self.store.state.mapItems)
            .navigationBarTitle(Text("YouBike"), displayMode: .automatic)
            .refreshable { self.fetch() }
        }
        .alert(Text("\(self.error?.localizedDescription ?? "")"), isPresented: .constant(self.error != nil), actions: {
            Button("OK") {
                
                self.fetch()
            }
        })
        .onAppear(perform: self.fetch)
        .searchable(text: self.$searchKeyword)
        .onChange(of: self.searchKeyword) { newValue in
            
            self.search(with: newValue)
        }
    }
    
    func fetch()
    {
        self.error = nil
        
        do {
            
            try self.store.send(.fetchData)
        } catch {
            
            self.error = error
        }
    }
    
    func search(with keyword: String)
    {
        self.error = nil
        
        do {
            
            try self.store.send(.search(keyword))
        } catch {
            
            self.error = error
        }
    }
}

struct ContentView_Previews: PreviewProvider
{
    static var previews: some View
    {
        ContentView()
            .environmentObject(kYouBikeStore)
            .previewDevice(.iPad)
    }
}
