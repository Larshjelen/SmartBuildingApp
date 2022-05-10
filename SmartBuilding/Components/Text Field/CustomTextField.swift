//
//  CustomTextField.swift
//  SmartBuilding
//
//  Created by Ammar Khalil on 10/05/2022.
//

import Foundation

import UIKit
class CustomTextField : UITextField {
    
        var styleAttributes = StyleAttributes()
        var helpers = Utils()
    
    override func awakeFromNib() {
        
        layer.borderWidth = 0.5
        layer.cornerRadius = 8
       layer.borderColor = helpers.colorWithHexString(hexString: styleAttributes.backgroundDark).cgColor
       
      
        
    }
}
