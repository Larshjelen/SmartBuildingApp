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
    var filteredRoomData : MeetingRoomSearch!
    
    var utils = Utils()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: K.searchCellNibName, bundle: nil), forCellReuseIdentifier: K.searchCellIdentifier)
        
        if let data =  utils.loadCoordinatesJson(fileName: "Coordinates_Rebel"){
            searchMeetingRomData = data
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        
        textField.addTarget(self, action: #selector(textSearchChange(_:)), for: .editingChanged)
        
        filteredRoomData = searchMeetingRomData
        
    }
    
    
    @IBAction func clearTextField(_ sender: UIButton) {
        
        textField.text = nil
        filteredRoomData = searchMeetingRomData
        tableView.reloadData()
    }
    
    @IBAction func textSearchChange(_ sender: UITextField) {
     
        print("sasdas")
        if let text = textField.text {
            
            if text.isEmpty{
                filteredRoomData = searchMeetingRomData
                tableView.reloadData()
            }else {
                
                filteredRoomData.meetingRooms.removeAll{!$0.name.lowercased().contains(text)}
                tableView.reloadData()
            }
        }
        
    }
    

}

extension SearchBuildingViewController : UITableViewDataSource{
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return filteredRoomData.meetingRooms.count
    }
    
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.searchCellIdentifier, for: indexPath) as! SearchCell
        
         cell.roomName.text = filteredRoomData.meetingRooms[indexPath.row].name
        return cell
    }
    
}

extension SearchBuildingViewController : UITableViewDelegate{
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let mapVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "mapView") as? MapViewController
        
        mapVC?.searchedMeetingRoom = filteredRoomData.meetingRooms[indexPath.row]
        print(filteredRoomData.meetingRooms[indexPath.row].name)
        mapVC?.viewDidLoad()
        self.navigationController?.dismiss(animated: true)
        
    }
    
}
