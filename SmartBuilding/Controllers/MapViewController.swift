//
//  MapViewController.swift
//  SmartBuilding
//
//  Created by Lars Even Hjelen on 07/04/2022.
//

import UIKit
import PhoneFUEL
import CoreLocation
import CoreBluetooth
import PhoneFUELGoogleMaps

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
        print(manager?.getState()!)
        nextStartupStep()
    }
    
    private func nextStartupStep() {
        
        DispatchQueue.main.async {
            // Check location settings
            if self.needInput() {
                self.requestInput()
            } else if self.locationAuthorizationStatus == nil {
                // Wait for locationAuthorizationStatus to be set
                self.nextStartupStep()
            } else if self.locationAuthorizationStatus == .denied {
                let alertController = UIAlertController (title: "Location denied", message: "Go to Settings?", preferredStyle: .alert)
                let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in
                    guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                        return
                    }
                    if UIApplication.shared.canOpenURL(settingsUrl) {
                        UIApplication.shared.open(settingsUrl, completionHandler: nil)
                    }
                }
                alertController.addAction(settingsAction)
                let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
                alertController.addAction(cancelAction)
                self.present(alertController, animated: true, completion: nil)
            } else if self.locationAuthorizationStatus == .restricted {
                let alertController = UIAlertController (title: "Location restricted", message: "Need access to location", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
                alertController.addAction(cancelAction)
                self.present(alertController, animated: true, completion: nil)
            } else if self.locationAuthorizationStatus == .notDetermined {
                self.requestingLocationAuth = true
                self.clLocationManager.requestAlwaysAuthorization()
            } else if self.needAuthentication() {
                self.requestAuthentication()
            } else {
                self.startPhoneFUEL()
            }
        }
    }
}
