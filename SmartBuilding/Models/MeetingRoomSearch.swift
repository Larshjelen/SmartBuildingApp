//
//  MeetingRoomSearch.swift
//  SmartBuilding
//
//  Created by Ammar Khalil on 17/05/2022.
//

import Foundation

struct MeetingRoomSearch : Codable {
    
    let rooms : [Room]
}

struct Room : Codable {
    
    let name : String
    let location : Location
}

struct Location : Codable {
    
    let lat : Double
    let long : Double
}
