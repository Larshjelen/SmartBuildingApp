//
//  BookingDateViewController.swift
//  SmartBuilding
//
//  Created by Lars Even Hjelen on 15/05/2022.
//

import UIKit

class BookingDateViewController: UIViewController {
    
    
    @IBOutlet weak var bookingDate: UITextField!
    
    
    @IBOutlet weak var bookingTimeTil: UITextField!
    
    @IBOutlet weak var bookingTimeFrom: UITextField!
    
    
    @IBOutlet weak var dateDropIcon: UIImageView!
    
    @IBOutlet weak var timeFromDropicon: UIImageView!
    
    
    @IBOutlet weak var timeTilDropIcon: UIImageView!
    
    
    let datePicker = UIDatePicker()
    let timeFromPicker = UIDatePicker()
    let timeTilPicker = UIDatePicker()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        createDatePicker()
        createTimeFromPicker()
        createTimeTilPicker()
        
        bookingDate.addTarget(self, action: #selector(hideDateFieledIcon(sender:)), for: .editingDidBegin)
        bookingTimeFrom.addTarget(self, action: #selector(hideTimeFromFieledIcon(sender:)), for: .editingDidBegin)
        bookingTimeTil.addTarget(self, action: #selector(hideTimeTilFieledIcon(sender:)), for: .editingDidBegin)
    }
    
    
    @IBAction  func hideDateFieledIcon(sender : UIDatePicker){
        
        dateDropIcon.isHidden = true
    }
    @IBAction  func hideTimeFromFieledIcon(sender : UIDatePicker){
        
        timeFromDropicon.isHidden = true
        
    }
    @IBAction  func hideTimeTilFieledIcon(sender : UIDatePicker){
        
        timeTilDropIcon.isHidden = true
    }
    
    
    func createDatePicker(){
         let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneDatePressed))
        toolbar.setItems([doneBtn], animated: true)
        
        bookingDate.inputAccessoryView = toolbar
        bookingDate.inputView = datePicker
        
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
    }
    
    func createTimeFromPicker(){
        let toolbar = UIToolbar()
       toolbar.sizeToFit()

       let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneTimeFromPressed))
       toolbar.setItems([doneBtn], animated: true)

       bookingTimeFrom.inputAccessoryView = toolbar
       bookingTimeFrom.inputView = timeFromPicker

        timeFromPicker.datePickerMode = .time
       timeFromPicker.preferredDatePickerStyle = .wheels
    }
    
    @objc func doneTimeFromPressed(){
        let date = timeFromPicker.date
        let components = Calendar.current.dateComponents([.hour, .minute], from: date)
        let hour = components.hour
        let minutes = components.minute
          
        guard let selectedHour = hour, let selectedMintues = minutes else{
            return
        }
        bookingTimeFrom.text = ("\(selectedHour):\(selectedMintues)")
        timeFromDropicon.isHidden = false
         self.view.endEditing(true)
     }
//
    func createTimeTilPicker(){
        let toolbar = UIToolbar()
       toolbar.sizeToFit()

       let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneTimeTilPressed))
       toolbar.setItems([doneBtn], animated: true)

       bookingTimeTil.inputAccessoryView = toolbar
       bookingTimeTil.inputView = timeTilPicker

        timeTilPicker.datePickerMode = .time
       timeTilPicker.preferredDatePickerStyle = .wheels
    }

    @objc func doneTimeTilPressed(){
        let date = timeTilPicker.date
        let components = Calendar.current.dateComponents([.hour, .minute], from: date)
        let hour = components.hour
        let minutes = components.minute
        guard let selectedHour = hour, let selectedMinues = minutes else{
            return
        }
        bookingTimeTil.text = ("\(selectedHour):\(selectedMinues)")
        timeTilDropIcon.isHidden = false
        self.view.endEditing(true)
    }

    @objc func doneDatePressed(){
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        bookingDate.text = formatter.string(from: datePicker.date)
        dateDropIcon.isHidden = false
        self.view.endEditing(true)
    }
    
    //Navigation
    @IBAction func searchRoomsPressed(_ sender: UIButton) {
        
        let vc = UIStoryboard.init(name: "MeetingRoom", bundle: Bundle.main).instantiateViewController(withIdentifier: "meetingRoomsTable") as? MeetingRoomsTableViewController
         self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    
}
