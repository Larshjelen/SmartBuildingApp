//
//  MapViewController.swift
//  SmartBuilding
//
//  Created by Lars Even Hjelen on 07/04/2022.
//

import UIKit
import PhoneFUEL

class MapViewController: UIViewController, SPFLocationManagerDelegate {

    var delegate = CustomLocationManagerDelegate()
    var manager = SPFLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager!.delegate = self
        
        do{
        try SPFLocationService.setAuthenticationAnonymous("5E93GDgNgBXAjuxPc8GymBJsPfM4p89W")
        }catch  {
            print(error)
            return
            
        }
        
        

        

        manager!.startUpdatingLocation();
    }
}
