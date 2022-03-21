//
//  ViewController.swift
//  SmartBuilding
//
//  Created by Ammar Khalil on 21/03/2022.
//

import UIKit

class EventsViewController: UIViewController {

    @IBOutlet weak var eventTableView: UITableView!
    
    let eventManager = EventManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        eventManager.performRequest()
    }


}

