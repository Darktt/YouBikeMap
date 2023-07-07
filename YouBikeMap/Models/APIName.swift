//
//  APIName.swift
//  YouBikeMap
//
//  Created by Eden on 2023/7/4.
//

import Foundation

public
struct APIName
{
    public static
    var bikeMap: APIName = APIName("https://api.kcg.gov.tw/api/service/Get/b4dd9c40-9027-4125-8666-06bef1756092")
    
    public
    var url: URL
    
    private
    init(_ urlString: String)
    {
        self.url = URL(string: urlString)!
    }
}
