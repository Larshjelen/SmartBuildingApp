//
//  MeetingRoomSearch.swift
//  SmartBuilding
//
//  Created by Ammar Khalil on 17/05/2022.
//

import Foundation

struct MeetingRoomSearch : Codable {
    
    var meetingRooms : [SearchRoom]
}

struct SearchRoom : Codable {
    
    let name : String
    let location : SearchLocation
}

struct SearchLocation : Codable {
    
    let lat : Double
    let long : Double
}
