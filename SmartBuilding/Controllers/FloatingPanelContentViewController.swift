//
//  FloatingPanelContentViewController.swift
//  SmartBuilding
//
//  Created by Ammar Khalil on 19/04/2022.
//

import UIKit
import SafariServices

class FloatingPanelContentViewController: UIViewController, SFSafariViewControllerDelegate {

    private lazy var rebelAuthManager = RebelAuthManager(viewController: self)
    
    var meetingRomManager = MeetingRomManager()
    
    var mapViewController = MapViewController()
    
    @IBOutlet weak var meetingRoomButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        SharedClass.sharedInstance.styleForComponents(button: meetingRoomButton)
        
    }
    @IBAction func MeetingRoomPressed(_ sender: UIButton) {
       
        mapViewController.showMeetingRoomFloatingPanel()
    }
    
    @IBAction func authBtn(_ sender: UIButton) {
        
        rebelAuthManager.login()
        
    }
    
    @IBAction func getToekn(_ sender: Any) {
        
        meetingRomManager.sendRequest()
    }
}
