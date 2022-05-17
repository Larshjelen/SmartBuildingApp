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
    
    var 
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: K.searchCellNibName, bundle: nil), forCellReuseIdentifier: K.searchCellIdentifier)
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
