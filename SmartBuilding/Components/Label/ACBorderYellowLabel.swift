//
//  ACBorderYellowLabel.swift
//  SmartBuilding
//
//  Created by Lars Even Hjelen on 16/05/2022.
//

import Foundation

import UIKit
class AccessCodeBorderLabel : UILabel {
    
        var styleAttributes = StyleAttributes()
        var helpers = Utils()
    
    override func awakeFromNib() {
        
        layer.borderWidth = 1
        layer.cornerRadius = 8
       layer.borderColor = helpers.colorWithHexString(hexString: styleAttributes.primary).cgColor
       
      
        
    }
}
