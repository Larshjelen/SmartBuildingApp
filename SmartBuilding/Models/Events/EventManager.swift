//
//  EventManager.swift
//  SmartBuilding
//
//  Created by Ammar Khalil on 21/03/2022.
//

import Foundation

struct EventManager {
    
    let eventURL = "https://api.entraos.io/activity/list"
    
    func performRequest(){
        
        //create URL
        if let url = URL(string: eventURL) {
            
            
            // create url-session
            let session = URLSession(configuration: .default)
            
            //give sesstion a task
            let task = session.dataTask(with: url){ (data, response, error) in
                
                if error != nil {
                    
                print(error)
                    return
                }
                
                if let safeData = data {
                    
                    parseJSON(eventData: safeData)
                }
                
            }
            
            //start the task
            
            task.resume()
        }
        
        
    }
    
    func parseJSON(eventData : Data){
        
        let decoder = JSONDecoder()
        
        do{
            let decodedData =  try decoder.decode([EventData].self, from: eventData)
            print(decodedData[0].name)
            
        }catch {
            print(error)
        }
        
    }

}
