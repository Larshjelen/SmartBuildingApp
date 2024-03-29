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

class MapViewController: UIViewController, FloatingPanelControllerDelegate, UISearchBarDelegate{

    private lazy var openIdAuthenticationServiceDelegate = OpenIdAuthenticationServiceDelegate(viewController: self)
    private lazy var spfLocationManager = SPFLocationManager()

    private let clLocationManager = CLLocationManager()
    private var locationAuthorizationStatus: CLAuthorizationStatus!
    private var mapViewEnhancer: SPFGMSMapEnhancer?
    private var requestingLocationAuth = false
    private var haveRequestedInput = false
    var utils = Utils()
    
    var selectedRoomLat: Double?
    var selectedRoomLong: Double?
    
    @IBOutlet weak var wayfindingView: UIView!
    @IBOutlet weak var startWayfindingButton: FPButtons!
    @IBOutlet weak var wayFindingRoomName: UILabel!
    
    var fpcMain: FloatingPanelController!
    @IBOutlet weak var gMapView: GMSMapView!
    
    var mapMarker : GMSMarker!
    var infoWindow : CustomMapMarker!
    
    var roomCoordinates : Coordinates?
    
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
    
    //SELECTED ROOM TO NAVIGATE TO 
    var searchedMeetingRoom : SearchRoom?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // mapSearchField.delegate = self
        
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
        checkUserState()
        
        NotificationCenter.default.addObserver(self, selector: #selector(getSelectedRoom), name: .navigation, object: nil)
    
        getMeetingRoomsCoordinates()
    }
    
    
    func checkUserState (){
        
        let user = helpers.loadFromDB()
        
        guard let newUserName = user?.last?.isLoggedIn else  {return}
        
        print(newUserName)
    }
    
    
    @objc func getSelectedRoom(_ notification : NSNotification){
        
        searchedMeetingRoom = notification.userInfo?["room"] as? SearchRoom
        print("This is the meeting room you selected")
        wayFindingRoomName.text = searchedMeetingRoom?.name
        selectedRoomLat = searchedMeetingRoom?.location.lat
        selectedRoomLong = searchedMeetingRoom?.location.long
        fpcMain.removePanelFromParent(animated: true)
        wayfindingView.isHidden = false
        startWayfindingButton.isHidden = false
    }
    
    @IBAction func endNavigationPressed(_ sender: UIButton) {
        wayfindingView.isHidden = true
        fpcMain.addPanel(toParent: self, animated: true)
        
    }
    
    @IBAction func startNavigationPressed(_ sender: UIButton) {
        startWayfindingButton.isHidden = true
        //Start navigation
        
        
    }
    
    func startNavigation (){
        guard let lat = selectedRoomLat else {return}
        guard let long = selectedRoomLong else {return}
     
        
        if let spfLocationManager = self.spfLocationManager{
            
            print("location manager")

            guard let startLat = spfLocationManager.getLastKnownLocation()?.coordinate.latitude else {
                print("StartLat not given by spfLocationManager")
                return
            }
            

            guard let startLong = spfLocationManager.getLastKnownLocation()?.coordinate.longitude else {
                print("StartLong not given by spfLocationManager")
                return
        }
            print("Starting coordinates")
            guard let currentFloor = spfLocationManager.getLastKnownLocation()?.floor else {
                 return
            }
            print(startLat)
            let startLocation = SPFLocationBase.forCoordinate(CLLocationCoordinate2DMake(startLat, startLong), onFloor: Int(currentFloor))
            //onFloor:Int(currentFloor))
            if (currentFloor == 2){
                //if at the same floor, navigate direct to destination
                let endLocation = SPFLocationBase.forCoordinate(CLLocationCoordinate2DMake(lat, long), onFloor: 2)
                SPFWayfindingService.directions(from: startLocation, to: endLocation, optimize: false) { directions, locations, error in
                    if(error != nil) {
                        print("Unable to find directions (%s)");
                        return
                    }

                    guard let route = directions?.routes.first else {
                        print("Unable to find directions");
                        return
                    }

                    self.mapViewEnhancer?.startNavigation(route)
                }
    
            } else {
                //if not, take the elevator
                
                let endLocation = SPFLocationBase.forCoordinate(CLLocationCoordinate2DMake(59.91744954107789, 10.74023891971364), onFloor: 1)
                 SPFWayfindingService.directions(from: startLocation, to: endLocation, optimize: false) { directions, locations, error in
                     if(error != nil) {
                         print("Unable to find directions (%s)", error?.localizedDescription ?? "")
                         
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
        startWayfindingButton.backgroundColor = UIColor.black
        startWayfindingButton.titleLabel?.tintColor = UIColor.white
        startWayfindingButton.titleLabel!.text = "Avslutt"
        
        if(!isNavgating){
            isNavgating = !isNavgating
            self.mapViewEnhancer?.stopNavigation()
            startWayfindingButton.backgroundColor = utils.colorWithHexString(hexString: "#FFD400")
            startWayfindingButton.titleLabel?.tintColor = UIColor.black
            
            wayfindingView.isHidden = true
            fpcMain.addPanel(toParent: self, animated: true)
            
            
        }
    }
    
    @IBAction func searchPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "toSearchView", sender: self)
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
        
        fpcMain = FloatingPanelController()
    
        fpcMain.delegate = self
        
    
            guard let mainVC = storyboard?.instantiateViewController(withIdentifier: "fpc_controller") as? FloatingPanelContentViewController else {
                print("main view return")
                return
            }
            fpcMain.set(contentViewController: mainVC)
   
        // Add and show the views managed by the `FloatingPanelController` object to self.view.
        fpcMain.addPanel(toParent: self)

       
    }
    
    func getMeetingRoomsCoordinates(){
        
        guard let coordinates = coordinatesManager.loadJson(fileName: "Coordinates_Rebel") else {return}
        
        roomCoordinates = coordinates
    }
  
    func showAnnotations(){
        //Positions
       
        let elevatorFirstFloor = CLLocationCoordinate2D(latitude: 59.91745227315649, longitude: 10.740245569903445)
        let liberary = CLLocationCoordinate2D(latitude: 59.91709632470611, longitude: 10.740116439727924)
        let coffeeSecondFloor = CLLocationCoordinate2D(latitude: 59.91733119435588, longitude: 10.74000016879904)
        let toiletBigSecondFloor = CLLocationCoordinate2D(latitude: 59.917165288285304, longitude: 10.740115140875274)
        let toiletSmallSecondFloor = CLLocationCoordinate2D(latitude: 59.91703410651393, longitude: 10.740185031394864)
        
        let ada = CLLocationCoordinate2D(latitude: 59.917266462541185, longitude: 10.740013489228327)
        let matt = CLLocationCoordinate2D(latitude: 59.91736362560823, longitude: 10.740132334655604)
        let simula = CLLocationCoordinate2D(latitude: 59.91720312237747, longitude: 10.740112037522566)
        let javaBin = CLLocationCoordinate2D(latitude: 59.91722570766675, longitude: 10.739955484665929)
        let LKK = CLLocationCoordinate2D(latitude: 59.917146574871964, longitude: 10.739995238559287)
        let emmett = CLLocationCoordinate2D(latitude: 59.91711097487949, longitude: 10.7400361318589)
        let kim = CLLocationCoordinate2D(latitude: 59.91710124799489, longitude: 10.74005726488678)
        let ziggy = CLLocationCoordinate2D(latitude: 59.91704942258073, longitude: 10.740129738061885)
        let dorothy = CLLocationCoordinate2D(latitude: 59.91702860746778, longitude: 10.740184294991588)
        let james = CLLocationCoordinate2D(latitude: 59.917156141707935, longitude: 10.740105923339057)
        let hedy = CLLocationCoordinate2D(latitude: 59.91739626310092, longitude: 10.740073437318888)
        let alan = CLLocationCoordinate2D(latitude: 59.91722663759778, longitude: 10.740077978822486)
        let tandberg = CLLocationCoordinate2D(latitude: 59.91716457374579, longitude: 10.739947993091619)
        let printerRoom = CLLocationCoordinate2D(latitude: 59.917383197583185, longitude: 10.740112226052801)
        
        let elevatorFirstFloorMarker = GMSMarker(position: elevatorFirstFloor)
        let liberaryMarker = GMSMarker(position: liberary)
        let coffeeSecondFloorMarker = GMSMarker(position: coffeeSecondFloor)
        let toiletBigSecondFloorMarker = GMSMarker(position: toiletBigSecondFloor)
        let toiletSmallSecondFloorMarker = GMSMarker(position: toiletSmallSecondFloor)
        
        let adaMarker = GMSMarker(position: ada)
        let mattMarker = GMSMarker(position: matt)
        let simulaMarker = GMSMarker(position: simula)
        let javaBinMarker = GMSMarker(position: javaBin)
        let LKKMarker = GMSMarker(position: LKK)
        let emmettMarker = GMSMarker(position: emmett)
        let kimMarker = GMSMarker(position: kim)
        let ziggyMarker = GMSMarker(position: ziggy)
        let dorothyMarker = GMSMarker(position: dorothy)
        let jamesMarker = GMSMarker(position: james)
        let hedyMarker = GMSMarker(position: hedy)
        let alanMarker = GMSMarker(position: alan)
        let tandbergMarker = GMSMarker(position: tandberg)
      //  let printerRoomMarker = GMSMarker(position: printerRoom)
        
        toiletSmallSecondFloorMarker.icon = UIImage(named: "icon_toilet")
        elevatorFirstFloorMarker.icon = UIImage(named: "icon_elevator")
        liberaryMarker.icon = UIImage(named: "heis_ikon")
        coffeeSecondFloorMarker.icon = UIImage(named: "icon_coffee")
        toiletBigSecondFloorMarker.icon = UIImage(named: "icon_toilet")
        elevatorFirstFloorMarker.map = gMapView
        liberaryMarker.map = gMapView
        coffeeSecondFloorMarker.map = gMapView
        toiletBigSecondFloorMarker.map = gMapView
        toiletSmallSecondFloorMarker.map = gMapView
        
        adaMarker.icon = UIImage(named: "heis_ikon")
        mattMarker.icon = UIImage(named: "heis_ikon")
        simulaMarker.icon = UIImage(named: "heis_ikon")
        javaBinMarker.icon = UIImage(named: "heis_ikon")
        LKKMarker.icon = UIImage(named: "heis_ikon")
        emmettMarker.icon = UIImage(named: "heis_ikon")
        kimMarker.icon = UIImage(named: "heis_ikon")
        ziggyMarker.icon = UIImage(named: "heis_ikon")
        dorothyMarker.icon = UIImage(named: "heis_ikon")
        jamesMarker.icon = UIImage(named: "heis_ikon")
        hedyMarker.icon = UIImage(named: "heis_ikon")
        alanMarker.icon = UIImage(named: "heis_ikon")
        tandbergMarker.icon = UIImage(named: "heis_ikon")
        
        adaMarker.map = gMapView
        mattMarker.map = gMapView
        simulaMarker.map = gMapView
        javaBinMarker.map = gMapView
        LKKMarker.map = gMapView
        emmettMarker.map = gMapView
        kimMarker.map = gMapView
        ziggyMarker.map = gMapView
        dorothyMarker.map = gMapView
        jamesMarker.map = gMapView
        hedyMarker.map = gMapView
        alanMarker.map = gMapView
        tandbergMarker.map = gMapView
        
        
        
        //Add room markers
        
        guard let coordinates = roomCoordinates?.meetingRooms else {return}
        
        let roomOne = CLLocationCoordinate2D(latitude: (coordinates[0].location.lat), longitude: (coordinates[0].location.long))
        let roomOneMarker = GMSMarker(position: roomOne)
        roomOneMarker.icon = UIImage(named: "heis_ikon")
        roomOneMarker.map = gMapView
        
        
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
                print("started")
            }else {
                
               
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
                    print("is not positioning")
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

