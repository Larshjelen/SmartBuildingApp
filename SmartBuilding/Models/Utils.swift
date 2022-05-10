//
//  Helpers.swift
//  SmartBuilding
//
//  Created by Ammar Khalil on 28/03/2022.
//

import Foundation
import UIKit
import CoreData


struct Utils {
    
    
    
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
    
    
    //Convert hex to UIColor
    func colorWithHexString(hexString: String, alpha:CGFloat = 1.0) -> UIColor {
        
        // Convert hex string to an integer
        let hexint = Int(self.intFromHexString(hexStr: hexString))
        let red = CGFloat((hexint & 0xff0000) >> 16) / 255.0
        let green = CGFloat((hexint & 0xff00) >> 8) / 255.0
        let blue = CGFloat((hexint & 0xff) >> 0) / 255.0
        
        // Create color object, specifying alpha as well
        let color = UIColor(red: red, green: green, blue: blue, alpha: alpha)
        return color
    }

  private  func intFromHexString(hexStr: String) -> UInt32 {
        var hexInt: UInt32 = 0
        // Create scanner
        let scanner: Scanner = Scanner(string: hexStr)
        // Tell scanner to skip the # character
        scanner.charactersToBeSkipped = CharacterSet(charactersIn: "#")
        // Scan hex value
        scanner.scanHexInt32(&hexInt)
        return hexInt
    }
    
    func saveToDB(context : NSManagedObjectContext){
        
        do{
            try context.save()
        }catch{
            print(error.localizedDescription)
        }
        
    }
    
    func loadFromDB(context : NSManagedObjectContext) -> [User]?{
        let request : NSFetchRequest<User> = User.fetchRequest()
        do{
          let user =   try context.fetch(request)
          return user
        }catch{
            print(error.localizedDescription)
            return nil
        }
    }

}
