//
//  CustomButton.swift
//  SmartBuilding
//
//  Created by Ammar Khalil on 02/05/2022.
//

import Foundation

import UIKit

import UIKit
class SharedClass: UIButton {

    static let sharedInstance = SharedClass()

    func styleForComponents(button: UIButton) {
        button.layer.cornerRadius = 21
        button.clipsToBounds = true
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        button.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        button.layer.shadowOpacity = 1.0
        button.layer.shadowRadius = 1.0
        button.layer.masksToBounds = false
    }
}
