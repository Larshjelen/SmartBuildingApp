//
//  RoundedSearchBar.swift
//  SmartBuilding
//
//  Created by Lars Even Hjelen on 18/05/2022.
//

import Foundation

import UIKit
class RoundedSearchBar : UISearchBar {
    
        var styleAttributes = StyleAttributes()
        var helpers = Utils()
    
    override func awakeFromNib() {
        layer.cornerRadius = 8
    }
}
