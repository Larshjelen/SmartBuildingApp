//
//  MeetingRoomsDetailsViewController.swift
//  SmartBuilding
//
//  Created by Lars Even Hjelen on 13/05/2022.
//

import UIKit

class MeetingRoomsDetailsViewController: UIViewController {
    
    @IBOutlet weak var meetingRoomName: UILabel!
    @IBOutlet weak var meetingRoomImage: UIImageView!
    @IBOutlet weak var meetingRoomCapacity: UILabel!
    
    @IBOutlet weak var meetingRoomPrice: UILabel!
    
    @IBOutlet weak var aboutText: UILabel!
    var meetingRoom : MeetingRoomData?
    var utils = Utils()
    
    var bookingDate : String?
    var bookingTimeFrom : String?
    var bookingTimeTil : String?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        guard let selectedRoom = meetingRoom else {return}
        
        meetingRoomName.text = utils.substractRoomName(string: selectedRoom.name)
        meetingRoomImage.image = utils.urlToImage(StringImage: selectedRoom.imgUrl)
        meetingRoomPrice.text = "\(String(selectedRoom.priceList.Hourly.net_price)),- per time"
        meetingRoomCapacity.text = "\(selectedRoom.maxPersons) pax"
        aboutText.text = "Om \(utils.substractRoomName(string: selectedRoom.name))"
    }
    
    @IBAction func choosePressed(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "MeetingRoom", bundle: Bundle.main).instantiateViewController(withIdentifier: "bookingSummary") as? BookingSummaryViewController
         self.navigationController?.pushViewController(vc!, animated: true)
        
        guard let selectedRoomBookingDate = bookingDate else {return}
        guard let selectedRoomBookingTimeFrom = bookingTimeFrom else {return}
        guard let selectedRoomBookingTimeTil = bookingTimeTil else {return}
        
        vc?.bookingDate = selectedRoomBookingDate
        vc?.bookingTimeFrom = selectedRoomBookingTimeFrom
        vc?.bookingTimeTil = selectedRoomBookingTimeTil
        vc?.meetingRomName = meetingRoomName.text
        vc?.meetingRoomPrice = meetingRoomPrice.text
        vc?.meetingRoomCapacity = meetingRoomCapacity.text
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
