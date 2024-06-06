//
//  ContentView.swift
//  YouBikeMap
//
//  Created by Eden on 2023/7/4.
//

import SwiftUI

extension View
{
    func networkErrorAlert(text: String, isPresented: Binding<Bool>, action: @escaping () -> Void) -> some View
    {
        self.alert(Text(text), isPresented: isPresented) {
            
            Button("OK", action: action)
        }
    }
}

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
            .refreshable { self.fetch() }
        }
        .networkErrorAlert(text: "\(self.store.state.error?.message ?? "")", isPresented: .constant(self.store.state.error != nil)) {
            
            self.fetch()
        }
        .onAppear(perform: self.fetch)
        .searchable(text: self.$searchKeyword)
        .onChange(of: self.searchKeyword) { newValue in
            
            self.search(with: newValue)
        }
    }
    
    func fetch()
    {
        self.store.dispatch(.fetchData)
    }
    
    func search(with keyword: String)
    {
        self.store.dispatch(.search(keyword))
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
