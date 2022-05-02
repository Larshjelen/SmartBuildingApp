//
//  CoordinatesManager.swift
//  SmartBuilding
//
//  Created by Ammar Khalil on 02/05/2022.
//

import Foundation


protocol CoordinatesDelegate {
    
    func didReadCoordinatesdata(coordinates : Coordinates)
    
    func didFailWithError(error : Error)
}

struct CoordinatesManager {
    
    
    var delegate : CoordinatesDelegate?
    
    
    func loadJson(fileName: String){

        print("decoding file...")
        guard  let path = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            
          return
        }
        print(path)
        do{
           print("decoding file...")
            let data = try Data(contentsOf: path)
            let result = try JSONDecoder().decode(Coordinates.self, from: data)
            print(result.meetingRooms[0].name)
            delegate?.didReadCoordinatesdata(coordinates: result)
        }catch{
            delegate?.didFailWithError(error: error)
        }
        
    }
}
