//
//  GradientColorView.swift
//  SmartBuilding
//
//  Created by Lars Even Hjelen on 18/05/2022.
//

import Foundation
import UIKit

class GradientColorView: UIView {

    override func awakeFromNib() {
        
        let colorTop =  UIColor(red: 255.0/255.0, green: 149.0/255.0, blue: 0.0/255.0, alpha: 1.0).cgColor
            let colorBottom = UIColor(red: 255.0/255.0, green: 94.0/255.0, blue: 58.0/255.0, alpha: 1.0).cgColor
                        
            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = [colorTop, colorBottom]
            gradientLayer.locations = [0.0, 1.0]

    }
    

}
