//
//  ResturantsData.swift
//  SmartBuilding
//
//  Created by Lars Even Hjelen on 08/05/2022.
//

import Foundation

struct Resturants : Codable {
    
    let diSotto : DiSotto
    let yatai : Yatai
    let skraplanet : Skraplanet
}

struct DiSotto : Codable  {
    
    let name : String
    let days : String
    let hours : String
    let imageurl : String
    let description : String
}

struct Yatai : Codable  {
    
    let name : String
    let days : String
    let hours : String
    let imageurl : String
    let description : String
}

struct Skraplanet : Codable  {
    
    let name : String
    let days : String
    let hours : String
    let imageurl : String
    let description : String
}

