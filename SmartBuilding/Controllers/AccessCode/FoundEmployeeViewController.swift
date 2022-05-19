//
//  FoundEmployeeViewController.swift
//  SmartBuilding
//
//  Created by Lars Even Hjelen on 10/05/2022.
//

import UIKit

class FoundEmployeeViewController: UIViewController {
    
    
    @IBOutlet weak var employeeImage: UIImageView!
    
    @IBOutlet weak var employeeName: UILabel!
    
    @IBOutlet weak var employeePosition: UILabel!
    
    
    @IBOutlet weak var employeeCompany: UILabel!
    
    var employee : Employee?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let selectedEmployee = employee else {return}
        
        print(selectedEmployee.name)
    }
    
    @IBAction func notifyPressed(_ sender: UIButton) {
     //   let NotifiedVC = storyboard?.instantiateViewController(withIdentifier: "notifiedEmployee") as? NotifiedEmployeeViewController
        
      //  self.navigationController?.pushViewController(NotifiedVC!, animated: true)
    }
    

}
