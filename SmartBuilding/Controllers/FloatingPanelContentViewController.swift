//
//  FloatingPanelContentViewController.swift
//  SmartBuilding
//
//  Created by Ammar Khalil on 19/04/2022.
//

import UIKit
import CoreData
import SafariServices

extension Notification.Name {
    
    static let load = Notification.Name("load")
    static let navigation = Notification.Name("notification")
    static let accessCode = Notification.Name("accessCode")
}

class FloatingPanelContentViewController: UIViewController, SFSafariViewControllerDelegate {

    private lazy var rebelAuthManager = RebelAuthManager(viewController: self)
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var meetingRomManager = MeetingRomManager()
    
    var mapViewController = MapViewController()
    
    @IBOutlet weak var meetingRoomButton: UIButton!
    
    @IBOutlet weak var activeTextField: UITextField!
    @IBOutlet weak var hasAccessCodeView: UIView!
    @IBOutlet weak var getAccessCodeView: FPButtonShadow!
    
    
    
    @IBOutlet weak var hasBookingView: BorderView!
    @IBOutlet weak var bookingRoomName: UILabel!
    @IBOutlet weak var bookingRoomDate: UILabel!
    @IBOutlet weak var bookingRoomTime: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //checkUserStatus()
        loadBookingFromDB()
      //  let request : NSFetchRequest<User> = User.fetchRequest()
      //      do{

      //              let user = try context.fetch(request)
      //          print(user.last?.isLoggedIn)
      //          if user.last?.isLoggedIn == true {
                    
      //              print("Check user")
      //              getAccessCodeView.isHidden = false
                    
      //         }
                
      //      }catch{
      //          print(error.localizedDescription)
                
      //     }
        
        NotificationCenter.default.addObserver(self, selector: #selector(loadDB), name: .load, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateAccessCodeButton), name: .accessCode, object: nil)
        
    }
    
    @objc func loadDB() {
        loadBookingFromDB()
    }
    
    @objc func updateAccessCodeButton() {
        hasAccessCodeView.isHidden = false
        getAccessCodeView.isHidden = true
        
    }
    
//    func checkUserStatus() {
//
//        let request : NSFetchRequest<User> = User.fetchRequest()
//
//        do{
//            let user = try context.fetch(request)
//            if (user.last!.isEmployee == true) {
//                getAccessCodeView.isHidden = false
//            }
//        }catch{
//            print(error.localizedDescription)
//        }
//    }
    
    func loadBookingFromDB(){
        
        let request : NSFetchRequest<Booking> = Booking.fetchRequest()
        
            do{
              let booking = try context.fetch(request)
                if (booking.last?.roomName != nil) {
                    hasBookingView.isHidden = false
                
                    bookingRoomName.text = booking.last?.roomName
                    bookingRoomDate.text = booking.last?.bookingDate
                    let timeFrom = booking.last?.bookingStartTime
                    let timeTil = booking.last?.bookingEndTime
                    guard let bookingTimeFrom = timeFrom, let bookingTimeTil = timeTil else {return }
                    bookingRoomTime.text = "\(bookingTimeFrom)-\(bookingTimeTil)"
                } else {
                    hasBookingView.isHidden = true
                }
            }catch{
                print(error.localizedDescription)
                
            }
        
    }
    @IBAction func authBtn(_ sender: UIButton) {
        rebelAuthManager.login()
        
    }
    
    @IBAction func getToekn(_ sender: Any) {
        meetingRomManager.sendRequest()
    }

    
    //Navigation
    
    @IBAction func UserGetCodePressed(_ sender: UIButton) {
        performSegue(withIdentifier: "toEmployeeGenerateCode", sender: self)
    }
    
    @IBAction func inviteGuestPressed(_ sender: UIButton) {
       // performSegue(withIdentifier: "toInvite", sender: self)
        
    }
    
    @IBAction func meetSomeonePressed(_ sender: UIButton) {
        performSegue(withIdentifier: "toFindEmployee", sender: self)
    }
    
    @IBAction func bookRoomPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "toMeetingRoom", sender: self)
    }
    
    @IBAction func EventsPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "toEvents", sender: self)
    }
    
    
    
    func alertPressed() {
        print("Hello Ammar")
    }
    
    //Not functional warnings
    func notAvailableAlert() {
        let alert = UIAlertController(title: "Not Available", message: "This functionality is not available in this prototype.", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {action in self.alertPressed()}))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func resturantsPressed(_ sender: UIButton) {
        notAvailableAlert()
    }
    @IBAction func cafeteriaPressed(_ sender: UIButton) {
        notAvailableAlert()
    }
    @IBAction func newsPressed(_ sender: UIButton) {
        notAvailableAlert()
    }
    @IBAction func profilePressed(_ sender: UIButton) {
        notAvailableAlert()
    }
    @IBAction func contactUsPressed(_ sender: UIButton) {
        notAvailableAlert()
    }
    
    @IBAction func didTapAlertButton() {
        let customAlert = MyAlert()
        customAlert.showAlert(with: "Hello world", messge: "This is my alert", on: self)
    }
    
}

class MyAlert {
    
    struct Constants {
        static let backgroundAlphaTo: CGFloat = 0.6
    }
    
    private let backgroundView: UIView = {
        let backgroundView = UIView()
        backgroundView.backgroundColor = .black
        backgroundView.alpha = 0
        return backgroundView
    }()
    
    private let alertView: UIView = {
        let alert = UIView()
        alert.backgroundColor = .white
        alert.layer.masksToBounds = true
        alert.layer.cornerRadius = 12
        return alert
    }()
    
    func showAlert(with title: String, messge: String, on viewController: UIViewController) {
        guard let targetView = viewController.view else {
            return
        }
        backgroundView.frame = targetView.bounds
        targetView.addSubview(backgroundView)
        UIView.animate(withDuration: 0.25, animations: {
            self.backgroundView.alpha = Constants.backgroundAlphaTo
        })
        
    }
    
    func dismissAlert() {
        
    }
}
