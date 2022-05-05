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
    
    
    func loadJson(fileName: String) -> Coordinates?{

        
        guard  let path = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            
          return nil
        }
        
        do{
           print("doing")
            let data = try Data(contentsOf: path)
            print("data")
            let result = try JSONDecoder().decode(Coordinates.self, from: data)
            print("has decoded")
            print(result.elevator.elevatorFirst.floor)
            return result
        }catch{
            print(error.localizedDescription)
            return nil
        }
        
    }
}
