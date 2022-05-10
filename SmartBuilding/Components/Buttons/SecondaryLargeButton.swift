//
//  SecondaryLargeButton.swift
//  SmartBuilding
//
//  Created by Ammar Khalil on 05/05/2022.
//

import Foundation
import UIKit
class SecondaryLargeButton : UIButton {
    
        var styleAttributes = StyleAttributes()
        var helpers = Utils()
    
    override func awakeFromNib() {
        
        backgroundColor = helpers.colorWithHexString(hexString: "#3C3C3C")
        titleLabel?.text = "Button"
        layer.cornerRadius = 50
        layer.borderWidth = 0.5
        
    }
}
