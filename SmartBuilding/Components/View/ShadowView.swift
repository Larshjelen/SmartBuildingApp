//
//  ShadowView.swift
//  SmartBuilding
//
//  Created by Lars Even Hjelen on 16/05/2022.
//

import Foundation
import UIKit

class ShadowView : UIView {
    
    
    override func awakeFromNib() {
        layer.shadowOffset = CGSize(width: 0, height: 9)
        layer.shadowOpacity = 0.15
        layer.shadowRadius = 8
    }
}
