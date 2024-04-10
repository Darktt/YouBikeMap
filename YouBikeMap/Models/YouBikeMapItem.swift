//
//  YouBikeMapItem.swift
//  YouBikeMap
//
//  Created by Eden on 2023/7/4.
//

import Foundation
import CoreLocation
import JsonProtection

/**
     sno(站點代號)、
     sna(場站中文名稱)、
     tot(場站總停車格)、
     sbi(場站目前車輛數量)、
     sarea(場站區域)、
     mday(資料更新時間)、
     lat(緯度)、
     lng(經度)、
     ar(地點)、
     sareaen(場站區域英文)、
     snaen(場站名稱英文)、
     aren(地址英文)、
     bemp(空位數量)、
     act(全站禁用狀態)、
     srcUpdateTime(YouBike2.0系統發布資料更新的時間)、
     updateTime(大數據平台經過處理後將資料存入DB的時間)、
     infoTime(各場站來源資料更新時間)、
     infoDate(各場站來源資料更新時間)
 */

public
struct YouBikeMapItem
{
    // MARK: - Properties -
    
    /// 所在城市
    public private(set)
    var city: String?
    
    /// 站點名稱
    public
    var name: String {
        
        guard let name = self.privateName else {
            
            return ""
        }
        
        var trimString = TrimString(trimSetting: .prefix("YouBike2.0_"))
        trimString.wrappedValue = name
        
        return trimString.wrappedValue
    }
    
    private
    var privateName: String?
    
    /// 站點所在區域
    public private(set)
    var area: String?
    
    /// 站點描述
    public private(set)
    var subtitle: String?
    
    /// 站點編號
    @NumberProtection
    public
    var number: Int?
    
    /// 總停車數量
    @NumberProtection
    public
    var numberOfTotalBikes: Int?
    
    /// 可借出數量
    @NumberProtection
    public
    var numberOfRentableBikes: Int?
    
    /// 可停車數量
    @NumberProtection
    public
    var numberOfParkingSpace: Int?
    
    /// 站點是否可用
    @BoolProtection
    public
    var isActivate: Bool?
    
    /// 詳細車輛資訊
    public private(set)
    var detail: Detail?
    
    @NumberProtection
    private
    var latitude: Double?
    
    @NumberProtection
    private
    var longitude: Double?
    
    /// 站點經緯度
    public
    var coordinate: CLLocationCoordinate2D {
        
        CLLocationCoordinate2D(latitude: self.latitude ?? 0.0, longitude: self.longitude ?? 0.0)
    }
}

public
extension YouBikeMapItem
{
    static var dummyItem: YouBikeMapItem {
        
        var mapItem = YouBikeMapItem()
        mapItem.city = "高雄市"
        mapItem.privateName = "YouBike2.0_後勁鳳屏宮"
        mapItem.area = "楠梓區"
        mapItem.subtitle = "後勁東路/後勁東路30巷(西南側)"
        mapItem.number = Int.random(in: 100 ... 10000)
        mapItem.numberOfTotalBikes = 13
        mapItem.numberOfRentableBikes = 9
        mapItem.numberOfParkingSpace = 99
        mapItem.isActivate = true
        mapItem.detail = Detail(numberOfYouBikes: 8, numberOfPowerYouBike: 0)
        mapItem.latitude = 22.71517
        mapItem.longitude = 120.31425
        
        return mapItem
    }
}

extension YouBikeMapItem: Decodable
{
    private enum CodingKeys: String, CodingKey
    {
        case city = "scity"
        
        case privateName = "sna"
        
        case area = "sarea"
        
        case subtitle = "ar"
        
        case number = "sno"
        
        case numberOfTotalBikes = "tot"
        
        case numberOfRentableBikes = "sbi"
        
        case numberOfParkingSpace = "bemp"
        
        case isActivate = "act"
        
        case detail = "sbi_detail"
        
        case latitude = "lat"
        
        case longitude = "lng"
    }
}

extension YouBikeMapItem: Identifiable
{
    public
    var id: String {
        
        "\(self.number ?? 0)" + (self.privateName ?? "")
    }
}

extension YouBikeMapItem: Equatable
{
    public static func == (lhs: YouBikeMapItem, rhs: YouBikeMapItem) -> Bool
    {
        lhs.id == rhs.id
    }
}

extension YouBikeMapItem: Hashable
{
    public func hash(into hasher: inout Hasher)
    {
        self.number?.hash(into: &hasher)
        self.name.hash(into: &hasher)
    }
}

// MARK: - YouBikeMapItem.Detail -

public
extension YouBikeMapItem
{
    struct Detail
    {
        /// 傳統 YouBike 數量
        @NumberProtection
        public
        var numberOfYouBikes: Int?
        
        /// 電動 YouBike 數量
        @NumberProtection
        public
        var numberOfPowerYouBike: Int?
    }
}

extension YouBikeMapItem.Detail: Decodable
{
    private
    enum CodingKeys: String, CodingKey
    {
        case numberOfYouBikes = "yb2"
        
        case numberOfPowerYouBike = "eyb"
    }
}
