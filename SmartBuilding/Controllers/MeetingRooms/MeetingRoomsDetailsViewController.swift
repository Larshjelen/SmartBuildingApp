//
//  MeetingRoomsDetailsViewController.swift
//  SmartBuilding
//
//  Created by Lars Even Hjelen on 13/05/2022.
//

import UIKit

class MeetingRoomsDetailsViewController: UIViewController {
    
    @IBOutlet weak var meetingRoomName: UILabel!
    @IBOutlet weak var meetingRoomImage: UIImage!
    @IBOutlet weak var meetingRoomCapacity: UILabel!
    @IBOutlet weak var meetingRoomPrice: UILabel!
    
    
    var meetingRoom : MeetingRoomData?
    var utils = Utils()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        guard let selectedRoom = meetingRoom else {return}
        
        meetingRoomName.text = selectedRoom.name
        meetingRoomImage = utils.urlToImage(StringImage: selectedRoom.imgUrl)
        meetingRoomPrice.text = String(selectedRoom.priceList.Hourly.net_price)
        meetingRoomCapacity.text = "\(selectedRoom.maxPersons) pax"
    }
    
    @IBAction func choosePressed(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "MeetingRoom", bundle: Bundle.main).instantiateViewController(withIdentifier: "bookingSummary") as? PersonaliaViewController
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
