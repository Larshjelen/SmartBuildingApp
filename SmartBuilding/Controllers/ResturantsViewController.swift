//
//  ResturantsViewController.swift
//  SmartBuilding
//
//  Created by Lars Even Hjelen on 08/05/2022.
//

import Foundation
import UIKit

class ResturantsViewController: UIViewController, UITableViewDelegate{
    
    
    
    
    @IBOutlet weak var resturantsTableView: UITableView!
    
    
    var resturantsManager = ResturantsManager()
    
    
    var resturantsViewController = ResturantsViewController()
    
    var resturantImage : UIImage?
    
    var fetchedEvents : [EventData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
