//
//  MeetingRomManager.swift
//  SmartBuilding
//
//  Created by Ammar Khalil on 26/04/2022.
//

import Foundation



struct MeetingRomManager{
    
    var rebelAuthManger = RebelAuthManager()
    let userInfoEndpoint = URL(string: "https://api-qa.entraos.io/booking/rooms")
    
    
    
    func sendRequest(){
        
        var request = URLRequest(url: userInfoEndpoint!)
        let accessToken = rebelAuthManger.getSavedRebelToken()
        request.httpMethod = "GET"
        request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { (data, response , error) in
            guard let data = data else { return }
            print(String(data: data, encoding: .utf8) ?? "Invalid JSON")
        }.resume()
    
}
    
}
