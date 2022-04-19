//
//  FloatingPanelContentViewController.swift
//  SmartBuilding
//
//  Created by Ammar Khalil on 19/04/2022.
//

import UIKit
import SafariServices

class FloatingPanelContentViewController: UIViewController, SFSafariViewControllerDelegate {

    let authUrl =  "https://api.entraos.io/person​/persons/authorize?clientId=g3PLRTK4OAnTWQGd0vbaGG.Cp7GlNLFyE9hA26qP5r0-&applicationName=Rebel Wayfinder&applicationUrl=http://localhost/&redirectUrl=SmartBuildingAuth://"

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func authBtn(_ sender: UIButton) {
        
        print("safari")
        if let url = URL(string: authUrl){
            UIApplication.shared.open(url)
        }
        
    }
    
}
