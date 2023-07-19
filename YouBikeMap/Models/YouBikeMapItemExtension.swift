//
//  YouBikeMapItemExtension.swift
//
//  Created by Eden on 2023/7/19.
//  
//

import SwiftUI
import MapKit

public
extension YouBikeMapItem
{
    var region: MKCoordinateRegion {
        
        MKCoordinateRegion(center: self.coordinate, latitudinalMeters: 750, longitudinalMeters: 750)
    }
}
