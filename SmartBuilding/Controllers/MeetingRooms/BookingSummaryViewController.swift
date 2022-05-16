//
//  BookingSummaryViewController.swift
//  SmartBuilding
//
//  Created by Lars Even Hjelen on 13/05/2022.
//

import UIKit

class BookingSummaryViewController: UIViewController {
    
    
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var date: UILabel!
    
    @IBOutlet weak var time: UILabel!
    
    @IBOutlet weak var capacity: UILabel!
    
    
    @IBOutlet weak var price: UILabel!
    
    var meetingRomName : String?
    var meetingRoomCapacity : String?
    var meetingRoomPrice : String?
    var bookingDate : String?
    var bookingTimeFrom : String?
    var bookingTimeTil : String?

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let selectedMeetingRoomName = meetingRomName else {return}
        guard let selectedMeetingRoomCapacity = meetingRoomCapacity else {return}
        guard let selectedMeetingRoomPrice = meetingRoomPrice else {return}
        guard let selectedMeetingRoomDate = bookingDate else {return}
        guard let selectedMeetingRoomTimeFrom = bookingTimeFrom else {return}
        guard let selectedMeetingRoomTimeTil = bookingTimeTil else {return}
        
        name.text = selectedMeetingRoomName
        date.text = selectedMeetingRoomDate
        time.text = "\(selectedMeetingRoomTimeFrom):\(selectedMeetingRoomTimeTil)"
        price.text = selectedMeetingRoomPrice
        capacity.text = selectedMeetingRoomCapacity
        
       
    }
    

    @IBAction func applePayPressed(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "MeetingRoom", bundle: Bundle.main).instantiateViewController(withIdentifier: "bookingConfirmation") as? BookingConfirmationViewController
         self.navigationController?.pushViewController(vc!, animated: true)
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
