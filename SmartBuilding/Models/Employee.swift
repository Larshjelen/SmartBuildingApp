//
//  Employee.swift
//  SmartBuilding
//
//  Created by Lars Even Hjelen on 15/05/2022.
//

import Foundation

struct EmployerData : Codable {

    let employerData : [Employee]
}

struct Employee : Codable {

    let name : String
    let company : String
    let position : String
    let image : String
}
