//
//  ResturantsManager.swift
//  SmartBuilding
//
//  Created by Lars Even Hjelen on 08/05/2022.
//

import Foundation


protocol ResturantsDelegate {
    
    func didReadResturantsdata(resturants : Resturants)
    
    func didFailWithError(error : Error)
}

struct ResturantsManager {
    
    
    var delegate : ResturantsDelegate?
    
    
    func loadJson(fileName: String) -> Resturants?{

        
        guard  let path = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            
          return nil
        }
        
        do{
           print("doing")
            let data = try Data(contentsOf: path)
            print("data")
            let result = try JSONDecoder().decode(Resturants.self, from: data)
            print("has decoded")
            print(result.diSotto.description)
            return result
        }catch{
            print(error.localizedDescription)
            return nil
        }
        
    }
}

