//
//  EventDetailsViewController.swift
//  SmartBuilding
//
//  Created by Ammar Khalil on 28/03/2022.
//

import UIKit

class EventDetailsViewController: UIViewController {
    
    var selectedEvent: EventData?
    var helpers = Helpers()
    
    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var eventDescription: UILabel!
    @IBOutlet weak var eventStart: UILabel!
    @IBOutlet weak var eventDate: UILabel!
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        eventName.text = selectedEvent!.name
        eventDescription.text = selectedEvent!.descriptiveActivityMarkdown
        
        let formattedTime = helpers.getFormatedDate(date_string: selectedEvent!.startDateAndTime, dateFormat: "yyyy-MM-dd'T'HH:mm:ssZ", desiredFormat: "dd-MM-yyyy")
        eventStart.text = formattedTime
        
        let imageKey = selectedEvent!.headliner
   
        if let image = selectedEvent!.captionAndActivityImages[imageKey]{
            let convertedImage = helpers.urlToImage(StringImage: image)
            eventImage.image = convertedImage
            
        }
}
    
    //Open Tickets-URL
    @IBAction func eventTicketButton(_ sender: UIButton) {
        if let url = URL(string: selectedEvent!.activityPosterUrl) {
                UIApplication.shared.open(url)
              } else {
                print("url is not correct")
              }
    }

}
