//
//  EventDetailsViewController.swift
//  SmartBuilding
//
//  Created by Ammar Khalil on 28/03/2022.
//

import UIKit

class EventDetailsViewController: UIViewController {
    
    var selectedEvent: EventData?
    
    
    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var eventName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        eventName.text = "selectedEvent"

}
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
