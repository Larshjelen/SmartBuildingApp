//
//  FPButtonShadow.swift
//  SmartBuilding
//
//  Created by Lars Even Hjelen on 16/05/2022.
//

import Foundation
import UIKit

class FPButtonShadow : UIButton {
    
    
    override func awakeFromNib() {
        layer.cornerRadius = 8
        layer.shadowOffset = CGSize(width: 0, height: 7)
        layer.shadowOpacity = 0.15
        layer.shadowRadius = 8
    }
}
