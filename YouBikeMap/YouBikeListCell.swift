//
//  YouBikeListCell.swift
//  YouBikeMap
//
//  Created by Eden on 2023/7/5.
//

import SwiftUI

public
struct YouBikeListCell: View
{
    public private(set)
    var mapItem: YouBikeMapItem
    
    public
    var body: some View {
        
        VStack(spacing: 10.0) {
            
            HStack(alignment: .top) {
                
                VStack(alignment: .leading) {
                    
                    Text(self.mapItem.name ?? "")
                        .bold()
                    
                    Text(self.mapItem.subtitle ?? "")
                }
                
                Spacer()
                
                VStack(alignment: .leading) {
                    
                    Label("\(self.mapItem.numberOfRentableBikes ?? 0)", systemImage: "bicycle.circle")
                        .foregroundColor(.blue)
                    
                    Label("\(self.mapItem.numberOfParkingSpace ?? 0)", systemImage: "parkingsign.circle")
                        .foregroundColor(.green)
                }
            }
            
            Line(style: .single)
        }
    }
}

struct YouBikeListCell_Previews: PreviewProvider
{
    static var previews: some View {
        YouBikeListCell(mapItem: .dummyItem)
    }
}
