//
//  MeetingRoomData.swift
//  SmartBuilding
//
//  Created by Ammar Khalil on 15/05/2022.
//

import Foundation


struct MeetingRoomData : Codable {
    
    let name : String
    let maxPersons : Int
    let imgUrl : String
    let priceList : PriceList
}

struct PriceList :  Codable {
    
    let Hourly : HourlyPrice
}

struct HourlyPrice : Codable{
    
    let net_price : Int
}
