//
//  BookingDetailsViewController.swift
//  SmartBuilding
//
//  Created by Lars Even Hjelen on 13/05/2022.
//

import UIKit
import CoreData

class BookingDetailsViewController: UIViewController {
    
    
    @IBOutlet weak var roomImage: UIImageView!
    @IBOutlet weak var bookingDate: UILabel!
    @IBOutlet weak var bookingTime: UILabel!
    @IBOutlet weak var roomCapacity: UILabel!
    @IBOutlet weak var roomPrice: UILabel!
    
    @IBOutlet weak var roomName: UILabel!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var utils = Utils()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadBookingFromDB()
    }
    

    
    func loadBookingFromDB(){
        
        let request : NSFetchRequest<Booking> = Booking.fetchRequest()
            do{
              let booking = try context.fetch(request)
                
                roomName.text = booking.last?.roomName
                roomImage.image = utils.urlToImage(StringImage: (booking.last?.roomImage)!)
                bookingDate.text = booking.last?.bookingDate
                roomCapacity.text = booking.last?.roomCapacity
                roomPrice.text = booking.last?.roomPrice
                let timeFrom = booking.last?.bookingStartTime
                let timeTil = booking.last?.bookingEndTime
                guard let bookingTimeFrom = timeFrom, let bookingTimeTil = timeTil else {return }
                bookingTime.text = "\(bookingTimeFrom)-\(bookingTimeTil)"
                self.navigationController?.title = booking.last?.roomName
            }catch{
                print(error.localizedDescription)
                
            }
        
    }

}
