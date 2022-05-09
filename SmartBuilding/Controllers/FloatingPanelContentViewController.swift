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
    
    @IBOutlet weak var activeTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func eventsButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "eventsSegue", sender: self)
        //let vc = UIStoryboard.init(name: "Events", bundle: Bundle.main).instantiateViewController(withIdentifier: "events") as? EventsViewController
       // self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func MeetingRoomPressed(_ sender: UIButton) {
       
        
    }
    
    @IBAction func authBtn(_ sender: UIButton) {
        
        rebelAuthManager.login()
        
    }
    
    @IBAction func getToekn(_ sender: Any) {
        
        meetingRomManager.sendRequest()
    }
}
