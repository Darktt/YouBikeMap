//
//  MapView.swift
//  YouBikeMap
//
//  Created by Eden on 2023/7/19.
//

import SwiftUI
import MapKit

public struct MapView: View 
{
    var item: YouBikeMapItem
    
    public var body: some View {
        
        Map(coordinateRegion: .constant(self.item.region), annotationItems: [self.item]) {
            
            item in
            
            MapMarker(coordinate: item.coordinate, tint: .red)
        }.ignoresSafeArea()
    }
}

struct MapView_Previews: PreviewProvider 
{
    static var previews: some View {
        
        MapView(item: YouBikeMapItem.dummyItem)
    }
}
