//
//  BookingSummaryViewController.swift
//  SmartBuilding
//
//  Created by Lars Even Hjelen on 13/05/2022.
//

import UIKit

class BookingSummaryViewController: UIViewController {
    
    var meetingRomName : String?
    var meetingRoomCapacity : String?
    var meetingRoomPrice : String?
    var bookingDate : String
    var bookingTimeFrom : String
    var bookingTimeTil : String

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let selectedMeetingRoomName = meetingRomName else {return}
        
        print(selectedMeetingRoomName)
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
