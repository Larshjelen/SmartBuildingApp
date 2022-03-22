//
//  ViewController.swift
//  SmartBuilding
//
//  Created by Ammar Khalil on 21/03/2022.
//

import UIKit

class EventsViewController: UIViewController , EventManagerDelegate{
   
    

    @IBOutlet weak var eventTableView: UITableView!
    
    let eventManager = EventManager()
    
    var fetchedEvents : [EventData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //fetch api-data
        eventManager.performRequest()
        
        eventTableView.dataSource = self
        
        //Register cell nib
        
        eventTableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.eventCellIdentifier)
        
    }
    
    func didUpdateEvents(events: [EventData]) {
        
       fetchedEvents = events
        
    }
    
    func didFailWithError(error: Error) {
        
        print(error)
    }


}

extension EventsViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.eventCellIdentifier, for: indexPath) as! EventCell
        
        cell.eventName.text = "test"
        
        return cell
        
        
    }
    
    
}

