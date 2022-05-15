//
//  MeetingRoomManagerApi.swift
//  SmartBuilding
//
//  Created by Ammar Khalil on 15/05/2022.
//

import Foundation

protocol MeetingRoomDelegate {
 
    func didUpdateEvents(meetingRoomData : [MeetingRoomData])
    func didFailWithError(error : Error)
    
}

struct MeetingRoomManagerApi {
    
    var delegate : MeetingRoomDelegate?
    
    let meetingRoomsUrl = "https://api.entraos.io/booking/publicrooms"
    
    func performRequest(){
        //create URL
        if let url = URL(string: meetingRoomsUrl) {
            
            
            // create url-session
            let session = URLSession(configuration: .default)
            
            //give sesstion a task
            let task = session.dataTask(with: url){ (data, response, error) in
                
                if error != nil {
                   
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    
                    if let fetchedData =  parseJSON(meetingRoomData: safeData){
                                        
                        self.delegate?.didUpdateEvents(meetingRoomData: fetchedData)
                    }
       
                }
                
            }
            
            //start the task
            task.resume()
        }
    }
    
    func parseJSON(meetingRoomData : Data) -> [MeetingRoomData]?{
        
        let decoder = JSONDecoder()
        
        do{
            print("decoder...")
            let decodedData =  try decoder.decode([MeetingRoomData].self, from: meetingRoomData)
            return decodedData
           
            
        }catch {
            print("error2", error)
            delegate?.didFailWithError(error: error)
            return nil
        }
        
    }

}
