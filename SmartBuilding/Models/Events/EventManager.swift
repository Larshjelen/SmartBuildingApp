//
//  EventManager.swift
//  SmartBuilding
//
//  Created by Ammar Khalil on 21/03/2022.
//

import Foundation

// Protocol to send data to the controller

protocol EventManagerDelegate {
 
    func didUpdateEvents(events : [EventData])
    func didFailWithError(error : Error)
    
}

struct EventManager {
    
    var delegate : EventManagerDelegate?
    
    let eventURL = "https://api.entraos.io/activity/list"
    
    func performRequest(){
        
        //create URL
        if let url = URL(string: eventURL) {
            
            
            // create url-session
            let session = URLSession(configuration: .default)
            
            //give sesstion a task
            let task = session.dataTask(with: url){ (data, response, error) in
                
                if error != nil {
                    
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    
                    if let fetchedData =  parseJSON(eventData: safeData){
                                        
                        self.delegate?.didUpdateEvents(events: fetchedData)
                    }
       
                }
                
            }
            
            //start the task
            
            task.resume()
        }
        
        
    }
    
    func parseJSON(eventData : Data) -> [EventData]?{
        
        let decoder = JSONDecoder()
        
        do{
            let decodedData =  try decoder.decode([EventData].self, from: eventData)
            return decodedData
           
            
        }catch {
          
            delegate?.didFailWithError(error: error)
            
            return nil
        }
        
    }

}
