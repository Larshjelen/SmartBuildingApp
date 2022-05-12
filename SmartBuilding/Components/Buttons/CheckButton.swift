//
//  CheckButton.swift
//  SmartBuilding
//
//  Created by Lars Even Hjelen on 12/05/2022.
//

import Foundation
import UIKit

class CheckButton : UIButton {
    
    
    override func awakeFromNib() {
        contentHorizontalAlignment = .left
        layer.cornerRadius = 8
        //contentEdgeInsets = UIEdgeInsets(top:15,right:10,bottom:15,left:10)
    }
}
