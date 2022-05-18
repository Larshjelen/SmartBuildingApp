//
//  CornerShadowView.swift
//  SmartBuilding
//
//  Created by Lars Even Hjelen on 18/05/2022.
//

import UIKit

class CornerShadowView: UIView {

    override func awakeFromNib() {
        
        layer.cornerRadius = 8
        layer.shadowOffset = CGSize(width: 0, height: 9)
        layer.shadowOpacity = 0.15
        layer.shadowRadius = 8
        
    }
    

}
