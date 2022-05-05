//
//  CoordinatesData.swift
//  SmartBuilding
//
//  Created by Ammar Khalil on 02/05/2022.
//

import Foundation

struct Coordinates : Codable {
    
    let stairs : Stairs
    let elevator : Eelevator
    let cafeBar : CafeBar
    let exit : Exit
    let meetingRooms : [MeetingRooms]
}

struct Stairs : Codable  {
    
    let stairsFirst : StairsFirst
    let stairsSecond : StairsSecond
}

struct CafeBar : Codable {
    let floor : Int
    let lat : Double
    let long : Double
}

struct Exit : Codable {
    
    let floor : Int
    let lat : Double
    let long : Double
}

struct Eelevator : Codable  {
    
    let elevatorFirst : ElevatorFirst
    let elevatorSecond : ElevatorSecond
}

struct MeetingRooms : Codable {
    
    let name : String
    let floor : Int
    let location : Location
}

struct Location : Codable {
    let lat : Double
    let long : Double
}


struct StairsFirst : Codable {
    
    let lat : Double
    let long : Double
}

struct StairsSecond : Codable {
    
    let lat : Double
    let long : Double
}

struct ElevatorSecond : Codable {
    let floor : Int
    let lat : Double
    let long : Double
}

struct ElevatorFirst : Codable {
    let floor : Int
    let lat : Double
    let long : Double
}
