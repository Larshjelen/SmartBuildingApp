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
    @IBOutlet weak var eventDescription: UILabel!
    @IBOutlet weak var eventStart: UILabel!
    @IBOutlet weak var eventDate: UILabel!
    @IBAction func eventTicketButton(_ sender: UIButton) {
        if let url = URL(string: selectedEvent!.activityPosterUrl) {
                UIApplication.shared.open(url)
              } else {
                print("url is not correct")
              }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        eventName.text = selectedEvent!.name
        eventDescription.text = selectedEvent!.descriptiveActivityMarkdown
        
        
        let formattedTime = getFormatedDate(date_string: selectedEvent!.startDateAndTime, dateFormat: "yyyy-MM-dd'T'HH:mm:ssZ")
        eventStart.text = formattedTime
}
    func getFormatedDate(date_string:String,dateFormat:String)-> String{

           let dateFormatter = DateFormatter()
           dateFormatter.locale = Locale(identifier: "en_US_POSIX")
           dateFormatter.dateFormat = dateFormat

           let dateFromInputString = dateFormatter.date(from: date_string)
           dateFormatter.dateFormat = "dd-MM-yyyy" // Here you can use any dateformate for output date
           if(dateFromInputString != nil){
               return dateFormatter.string(from: dateFromInputString!)
           }
           else{
               debugPrint("could not convert date")
               return "N/A"
           }
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
