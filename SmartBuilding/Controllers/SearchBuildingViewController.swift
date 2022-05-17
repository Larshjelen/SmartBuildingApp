//
//  SearchBuildingViewController.swift
//  SmartBuilding
//
//  Created by Ammar Khalil on 17/05/2022.
//

import UIKit

class SearchBuildingViewController: UIViewController {

    
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    var searchMeetingRomData : MeetingRoomSearch!
    
    var utils = Utils()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: K.searchCellNibName, bundle: nil), forCellReuseIdentifier: K.searchCellIdentifier)
        
        if let data =  utils.loadCoordinatesJson(fileName: "Coordinates_Rebel"){
            searchMeetingRomData = data
        }
        
        //tableView.delegate = self
        tableView.dataSource = self
        
    }
    

}

extension SearchBuildingViewController : UITableViewDataSource{
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return searchMeetingRomData.meetingRooms.count
    }
    
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.searchCellIdentifier, for: indexPath) as! SearchCell
        
         cell.roomName.text = searchMeetingRomData.meetingRooms[indexPath.row].name
        return cell
    }
    
}
