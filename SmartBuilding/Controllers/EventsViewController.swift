//
//  ViewController.swift
//  SmartBuilding
//
//  Created by Ammar Khalil on 21/03/2022.
//

import UIKit

class EventsViewController: UIViewController{
   
    

    @IBOutlet weak var eventTableView: UITableView!
    
    var eventManager = EventManager()
    
    var eventImage : UIImage?
    
    var fetchedEvents : [EventData] = []
    
    var refreshControll = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        eventTableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.eventCellIdentifier)
        
        
        eventTableView.dataSource = self
        eventManager.delegate = self
        
    
        //fetch api-data
        eventManager.performRequest()
        
        refreshControll.addTarget(self, action: #selector(self.updateTable(refreshController:)), for: UIControl.Event.valueChanged)
        eventTableView.addSubview(refreshControll)
        
    }
    
    
    // Update data on refresh
    @objc func updateTable(refreshController : UIRefreshControl){
        
        DispatchQueue.main.async {
            self.eventManager.performRequest()
            self.refreshControll.endRefreshing()
        }
    }
    


}

extension EventsViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return fetchedEvents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.eventCellIdentifier, for: indexPath) as! EventCell
        
        cell.eventName.text = fetchedEvents[indexPath.row].name
        
        let imageKey = fetchedEvents[indexPath.row].headliner
        
    
        
        if let image = fetchedEvents[indexPath.row].captionAndActivityImages[imageKey]{
            if let url = URL(string: image){
                if let data = try? Data(contentsOf: url){
                    eventImage = UIImage(data: data)

                    cell.eventImage.image = self.eventImage
                    
                    cell.selectionStyle = .none
                }
            }
        }
        
        return cell
        
        
    }
    
    
}

extension EventsViewController:EventManagerDelegate {
    func didUpdateEvents(events: [EventData]) {

        fetchedEvents = events

        DispatchQueue.main.async {
            self.eventTableView.reloadData()
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

extension  UITableView {
    
    
}

