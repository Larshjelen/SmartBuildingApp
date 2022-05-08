//
//  EventData.swift
//  SmartBuilding
//
//  Created by Ammar Khalil on 21/03/2022.
//

import Foundation


struct EventData : Decodable {
    
    let name : String
    let headliner : String
    let eventOrganizer : String
    let startDateAndTime: String
    let descriptiveActivityMarkdown: String
    let activityPosterUrl: String
    let captionAndActivityImages : [String : String]
    var organizedAtVenue : OrganizedVenue
}

struct OrganizedVenue : Decodable {
    
    let name  :  String
}


