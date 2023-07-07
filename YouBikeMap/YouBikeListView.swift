//
//  YouBikeListView.swift
//  YouBikeMap
//
//  Created by Eden on 2023/7/5.
//

import SwiftUI

public
struct YouBikeListView: View
{
    public private(set)
    var mapItems: Array<YouBikeMapItem>
    
    public var body: some View {
        
        ScrollView {
            
            LazyVStack {
                
                if self.mapItems.isEmpty {
                    
                    Text("Loading…")
                } else {
                    
                    ForEach(self.mapItems) {
                        
                        item in
                        
                        YouBikeListCell(mapItem: item)
                            .padding([.leading, .trailing], 5.0)
                    }
                }
            }
        }
    }
}

struct YouBikeListView_Previews: PreviewProvider
{
    static var previews: some View {
        
        YouBikeListView(mapItems: [.dummyItem, .dummyItem, .dummyItem])
    }
}
