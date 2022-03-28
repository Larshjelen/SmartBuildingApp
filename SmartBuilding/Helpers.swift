//
//  Helpers.swift
//  SmartBuilding
//
//  Created by Ammar Khalil on 28/03/2022.
//

import Foundation
import UIKit
struct Helpers {
    
    //Convert URL to image
    func urlToImage (StringImage : String) -> UIImage?{
        
        if let url = URL(string: StringImage){
            if let data = try? Data(contentsOf: url){
                if let image = UIImage(data: data){
                    
                    return image
                }
            }
        }
        return nil
    }
    
    //Format String-date
    func getFormatedDate(date_string:String,dateFormat:String, desiredFormat : String)-> String{
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = dateFormat
        
        let dateFromInputString = dateFormatter.date(from: date_string)
        dateFormatter.dateFormat = desiredFormat
        if(dateFromInputString != nil){
            return dateFormatter.string(from: dateFromInputString!)
        }
        else{
            return ("Error while converting the date")
        }
    }
}
