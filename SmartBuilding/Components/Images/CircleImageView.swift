//
//  CircleImageView.swift
//  SmartBuilding
//
//  Created by Lars Even Hjelen on 12/05/2022.
//

import Foundation
import UIKit

class CircleImageView : UIImageView {
    
    override func awakeFromNib() {
        layer.cornerRadius = (self.frame.width / 2)
        
    }
}
