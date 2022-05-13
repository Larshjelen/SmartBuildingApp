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
import PhoneFUELWayfinding
import FloatingPanel

class MapViewController: UIViewController, FloatingPanelControllerDelegate{

    private lazy var openIdAuthenticationServiceDelegate = OpenIdAuthenticationServiceDelegate(viewController: self)
    private lazy var spfLocationManager = SPFLocationManager()

    private let clLocationManager = CLLocationManager()
    private var locationAuthorizationStatus: CLAuthorizationStatus!
    private var mapViewEnhancer: SPFGMSMapEnhancer?
    private var requestingLocationAuth = false
    private var haveRequestedInput = false
    
        
    @IBOutlet weak var gMapView: GMSMapView!
    
 
    var mapMarker : GMSMarker!
    
    var infoWindow : CustomMapMarker!
    
   var isNavgating = false
    
    let MapStyle = """
        [
            {
              "featureType": "poi",
              "stylers": [
                { "visibility": "off" }
              ]
            }
        ]
        """

    var helpers = Utils()
    var coordinatesManager = CoordinatesManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            gMapView.mapStyle = try GMSMapStyle(jsonString: MapStyle)
        } catch {}
        
        gMapView.delegate = self
    
        clLocationManager.delegate = self
        if mapViewEnhancer == nil {
            mapViewEnhancer = SPFGMSMapEnhancer.init(mapView: gMapView)
            mapViewEnhancer?.settings.cameraFollowEnabled = true
            mapViewEnhancer?.settings.renderLocationOverlays = true
            mapViewEnhancer?.settings.renderLocationOutlines = true
        }
        showFloatingPanel()
        nextStartupStep()
        showAnnotations()
        
       
    }
    
    
    func startNavigation (){
        
        guard let constantCoordinates =  coordinatesManager.loadJson(fileName: "Coordinates_Rebel") else {
            return
        }
        
        if let spfLocationManager = self.spfLocationManager{

            guard let startLat = spfLocationManager.getLastKnownLocation()?.coordinate.latitude else {
                return
            }

            guard let startLong = spfLocationManager.getLastKnownLocation()?.coordinate.longitude else {

                return
        }
            guard let currentFloor = spfLocationManager.getLastKnownLocation()?.floor else {
                 return
            }
            let startLocation = SPFLocationBase.forCoordinate(CLLocationCoordinate2DMake(startLat, startLong), onFloor: Int(currentFloor))

            if (currentFloor == 2){
                //if at the same floor, navigate direct to destination
                let endLocation = SPFLocationBase.forCoordinate(CLLocationCoordinate2DMake(constantCoordinates.meetingRooms[0].location.lat, constantCoordinates.meetingRooms[0].location.long), onFloor: constantCoordinates.meetingRooms[0].floor)
                SPFWayfindingService.directions(from: startLocation, to: endLocation, optimize: false) { directions, locations, error in
                    if(error != nil) {
                        print("Unable to find directions (%s)", error?.localizedDescription ?? "");
                        return
                    }

                    guard let route = directions?.routes.first else {
                        print("Unable to find directions", error?.localizedDescription ?? "");
                        return
                    }

                    self.mapViewEnhancer?.startNavigation(route)
                }
    
            } else {
                //if not, take the elevator
                let endLocation = SPFLocationBase.forCoordinate(CLLocationCoordinate2DMake(constantCoordinates.elevator.elevatorFirst.lat, constantCoordinates.elevator.elevatorFirst.long), onFloor: constantCoordinates.elevator.elevatorFirst.floor)
                 SPFWayfindingService.directions(from: startLocation, to: endLocation, optimize: false) { directions, locations, error in
                     if(error != nil) {
                         print("Unable to find directions (%s)", error?.localizedDescription ?? "");
                         return
                     }

                     guard let route = directions?.routes.first else {
                         print("Unable to find directions", error?.localizedDescription ?? "");
                         return
                     }

                     self.mapViewEnhancer?.startNavigation(route)
                 }
                
            }

        }
    }
    
    //Toggle navigation
    @IBAction func calculateRouteBtn(_ sender: Any) {
       
        isNavgating = !isNavgating
        
        if(!isNavgating){
            self.mapViewEnhancer?.stopNavigation()
            
        }
    }
    
 
    
    
   
    
    func prepareWayfinding() {
        SPFWayfindingService.prepare() { prepared, error in
            if(!prepared) {
                print("Unable to prepare wayfinding (%s)", error?.localizedDescription ?? "");
            }
            else {
                print("Prepared wayfinding");
            }
        }
        
    }
  
    func showFloatingPanel(){
        
        let fpcMain = FloatingPanelController()
    
        fpcMain.delegate = self
        
    
            guard let mainVC = storyboard?.instantiateViewController(withIdentifier: "fpc_controller") as? FloatingPanelContentViewController else {
                print("main view return")
                return
            }
            fpcMain.set(contentViewController: mainVC)
   
        // Add and show the views managed by the `FloatingPanelController` object to self.view.
        fpcMain.addPanel(toParent: self)

       
    }
  
    func showAnnotations(){
        let position = CLLocationCoordinate2D(latitude: 52.649030, longitude: 1.174155)
        let locationMarker = GMSMarker(position: position)
        //locationMarker.icon = UIImage
        locationMarker.map = gMapView
        
    }
    
    private func nextStartupStep(){
    
        DispatchQueue.main.async {
            // Check location settings
            if self.needInput() {
                self.requestInput()
            } else if self.locationAuthorizationStatus == nil {
                // Wait for locationAuthorizationStatus to be set
                //self.nextStartupStep()
                self.startPhoneFUEL()
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
    
    private func needAuthentication() -> Bool {
        switch ForkbeardAuthentication.currentAuthenticationMethod {
        case .openId:
            return !openIdAuthenticationServiceDelegate.isAuthorized()
        case .anonymous:
            return false
        }
    }

    private func requestAuthentication() {
        switch ForkbeardAuthentication.currentAuthenticationMethod {
        case .openId:
            openIdAuthenticationServiceDelegate.login(loginCallback: { success in
                if success {
                   
                }
                self.nextStartupStep()
            })
        case .anonymous:
            nextStartupStep()
        }
    }

    private func needInput() -> Bool {
        print("needInput called")
        guard let name = UserDefaults.standard.string(forKey: UserDefaults.Keys.spfName) else {
            print("needInput else return true")
            return true
        }
        if name == "" {
            print("needInput if name blank return true")
            return true
        }
        print("needInput return haveRequestedInput")
        return !haveRequestedInput
    }

    private func requestInput() {
        print("requestInput called")
        haveRequestedInput = true
        let alertController = UIAlertController (title: "Configuration", message: nil, preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "Name"
            textField.text = UserDefaults.standard.string(forKey: UserDefaults.Keys.spfName)
            if textField.text == nil || textField.text == "" {
                textField.text = UIDevice.current.name
            }
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "Installation ID"
            textField.text = UserDefaults.standard.string(forKey: UserDefaults.Keys.spfInstallationId)
        }
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            let name = alertController.textFields?[0].text
            if name == nil || name == "" {
                let alertController = UIAlertController (title: "Name Required", message: "Please input a valid name.", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(cancelAction)
                self.present(alertController, animated: true, completion: {
                    self.nextStartupStep()
                })
                return
            }
            UserDefaults.standard.set(name, forKey: UserDefaults.Keys.spfName)
            let installationId = alertController.textFields?[1].text
            UserDefaults.standard.set(installationId, forKey: UserDefaults.Keys.spfInstallationId)
            UserDefaults.standard.synchronize()
            self.nextStartupStep()
        }))
        present(alertController, animated: true, completion: nil)
    }

    private func startPhoneFUEL() {
        switch ForkbeardAuthentication.currentAuthenticationMethod {
        case .openId:
            SPFLocationService.setAuthenticationDelegate(openIdAuthenticationServiceDelegate)
        case .anonymous:
            do {
                try SPFLocationService.setAuthenticationAnonymous(ForkbeardAuthentication.anonAuthApiKey)
            } catch {

            }
        }
        
        do {
            try SPFLocationService.setName(UserDefaults.standard.string(forKey: UserDefaults.Keys.spfName) ?? UIDevice.current.name)
            try SPFLocationService.setInstallationId(UserDefaults.standard.string(forKey: UserDefaults.Keys.spfInstallationId) ?? "")
        }
        catch _ {}
        
        spfLocationManager?.delegate = self
        spfLocationManager?.startUpdatingLocation()
       
    }
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        locationAuthorizationStatus = status
        if requestingLocationAuth {
            requestingLocationAuth = false
            nextStartupStep()
        }
    }
}

extension UserDefaults {
    struct Keys {
        static let spfName = "spf_name"
        static let spfInstallationId = "spf_installation_id"
    }
}

    
  

// MARK: Forkbeard location updates
extension MapViewController: SPFLocationManagerDelegate {
    
    func spfLocationManager(_ manager: SPFLocationManager, didUpdate location: SPFLocation?) {
        if let location = location {
            //NSLog("Forkbeard Location Update: \(location.coordinate.latitude),\(location.coordinate.longitude)"
            if isNavgating {
                startNavigation()
            }else {
                
                print("stop navigation")
            }
        } else {
            NSLog("Forkbeard Location Update: Unknown")
        }
        
      //  print(location?.coordinate.longitude, location?.coordinate.latitude)
        
        
    }

    
    
    func spfLocationManager(_ manager: SPFLocationManager, stateChanged state: SPFState?, withError error: Error?) {
        DispatchQueue.main.async {
            if let state = state {
                // prepare for wayfinding
                if state.isPositioning() {
                    self.prepareWayfinding()
                   
                }
                else {
                    
                }
            }
        }
    }
    
    
}

        
extension MapViewController : GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
    
        return infoWindow
    }
}

