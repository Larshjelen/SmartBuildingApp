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
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func authBtn(_ sender: UIButton) {
        
        rebelAuthManager.login()
    }
    
}
