//
//  MeetingRoomsTableViewController.swift
//  SmartBuilding
//
//  Created by Lars Even Hjelen on 13/05/2022.
//

import UIKit

class MeetingRoomsTableViewController: UIViewController {
    
    
    @IBOutlet weak var meetingRoomsTableView: UITableView!
    
    var meetingRoomManager = MeetingRoomManagerApi()
    var utils = Utils()
    var fetchedRooms : [MeetingRoomData] = []
    
    var bookingDate : String?
    var bookingTimeFrom : String?
    var bookingTimeTil : String?
    
    var refreshControll = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        meetingRoomsTableView.register(UINib(nibName: K.meetingRommCellNibName, bundle: nil), forCellReuseIdentifier: K.meetingRoomCellIdentifier)
        
        meetingRoomsTableView.delegate = self
        meetingRoomsTableView.dataSource = self
        meetingRoomManager.delegate = self
        
        //fetch api-data
        meetingRoomManager.performRequest()
    }
}

extension MeetingRoomsTableViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedRooms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.meetingRoomCellIdentifier, for: indexPath) as! MeetingRoomTableViewCell
        
        cell.roomName.text =  utils.substractRoomName(string: fetchedRooms[indexPath.row].name)
        cell.roomCapacity.text = "\(String(fetchedRooms[indexPath.row].maxPersons)) pax"
        cell.roomImage.image = utils.urlToImage(StringImage: fetchedRooms[indexPath.row].imgUrl)
        return cell
    }
}

extension MeetingRoomsTableViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let meetingRoomsDetailsVC = UIStoryboard.init(name: "MeetingRoom", bundle: Bundle.main).instantiateViewController(withIdentifier: "meetingRoomDetails") as? MeetingRoomsDetailsViewController
         self.navigationController?.pushViewController(meetingRoomsDetailsVC!, animated: true)
        
        let index = indexPath.row
        
        let selectedRoom = fetchedRooms[index]
        
        meetingRoomsDetailsVC!.meetingRoom = selectedRoom
        
    }
}

extension MeetingRoomsTableViewController : MeetingRoomDelegate {
    
    func didUpdateEvents(meetingRoomData: [MeetingRoomData]) {
        fetchedRooms = meetingRoomData
        DispatchQueue.main.async {
            self.meetingRoomsTableView.reloadData()
        }
    }
    
    func didFailWithError(error: Error) {
        
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error connecting to server", message: error.localizedDescription, preferredStyle: .alert)

                    // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

                    // show the alert
                    self.present(alert, animated: true, completion: nil)
        }
    }
}


