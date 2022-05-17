//
//  FloatingPanelContentViewController.swift
//  SmartBuilding
//
//  Created by Ammar Khalil on 19/04/2022.
//

import UIKit
import CoreData
import SafariServices

class FloatingPanelContentViewController: UIViewController, SFSafariViewControllerDelegate {

    private lazy var rebelAuthManager = RebelAuthManager(viewController: self)
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var meetingRomManager = MeetingRomManager()
    
    var mapViewController = MapViewController()
    
    @IBOutlet weak var meetingRoomButton: UIButton!
    
    @IBOutlet weak var activeTextField: UITextField!
    @IBOutlet weak var BottomAccesCodeView: UIView!
    @IBOutlet weak var TopAccessCodeView: UIView!
    @IBOutlet weak var MiddleAccessCodeView: UIView!
    
    @IBOutlet weak var bookingRoomName: UILabel!
    @IBOutlet weak var bookingRoomDate: UILabel!
    @IBOutlet weak var bookingRoomTime: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadBookingFromDB()
        
        
    }
    
    func loadBookingFromDB(){
        
        let request : NSFetchRequest<Booking> = Booking.fetchRequest()
            do{
              let booking = try context.fetch(request)
                
                bookingRoomName.text = booking.last?.roomName
                bookingRoomDate.text = booking.last?.bookingDate
                let timeFrom = booking.last?.bookingStartTime
                let timeTil = booking.last?.bookingEndTime
                guard let bookingTimeFrom = timeFrom, let bookingTimeTil = timeTil else {return }
                bookingRoomTime.text = "\(bookingTimeFrom)-\(bookingTimeTil)"
            }catch{
                print(error.localizedDescription)
                
            }
        
    }
    
    @IBAction func eventsButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "toEvents", sender: self)
        //let vc = UIStoryboard.init(name: "Events", bundle: Bundle.main).instantiateViewController(withIdentifier: "events") as? EventsViewController
       // self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    //Testing overlaying buttons
    
    @IBAction func UserGetCodePressed(_ sender: UIButton) {
        performSegue(withIdentifier: "toEmployeeGenerateCode", sender: self)
    }
    
    @IBAction func MiddleAccessCodeButtonPressed(_ sender: UIButton) {
        print("MiddleAccessCodeButton Pressed")
    }
    @IBAction func BottomAccessCodeButtonPressed(_ sender: UIButton) {
        print("BottomAccessCodeButton Pressed")
    }
    @IBAction func SecondButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "toFindEmployee", sender: self)
    }
    @IBAction func ThirdButtonPressed(_ sender: UIButton) {
        //BottomAccesCodeView.isHidden = false
        //TopAccessCodeView.isHidden = false
        MiddleAccessCodeView.isHidden = false
        performSegue(withIdentifier: "toMeetingRoom", sender: self)
    }
    
    @IBAction func EventsPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "toEvents", sender: self)
    }
    
    
    
    @IBAction func accessCodeButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "toFindEmployee", sender: self)
    }
    
    @IBAction func meetingRoomButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "toMeetingRoom", sender: self)
    }
    @IBAction func inviteGuestPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "toInvite", sender: self)
    }
    
    @IBAction func MeetingRoomPressed(_ sender: UIButton) {
       
        
    }
    
    @IBAction func authBtn(_ sender: UIButton) {
        
        rebelAuthManager.login()
        
    }
    
    @IBAction func getToekn(_ sender: Any) {
        
        meetingRomManager.sendRequest()
    }
}
