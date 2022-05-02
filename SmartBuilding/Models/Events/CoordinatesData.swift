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
    let meetingRooms : [MeetingRooms]
}

struct Stairs : Codable  {
    
    let stairsFirst : StairsFirst
    let stairsSecond : StairsSecond
}

struct Eelevator : Codable  {
    
    let elevatorFirst : ElevatorFirst
    let elevatorSecond : ElevatorSecond
}

struct MeetingRooms : Codable {
    
    let name : String
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
    
    let lat : Double
    let long : Double
}

struct ElevatorFirst : Codable {
    
    let lat : Double
    let long : Double
}
