//
//  ChooseUserViewController.swift
//  SmartBuilding
//
//  Created by Ammar Khalil on 09/05/2022.
//

import UIKit

class ChooseUserViewController: UIViewController {
    
    
    
    @IBOutlet weak var guestBtn: UIButton!
    
    @IBOutlet weak var WorkAtRebelBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    
    
    @IBAction func EmployeePressed(_ sender: Any) {
        
        self.performSegue(withIdentifier: "ifEmployee", sender: self)
  
    }
    
    @IBAction func guestBtnPressed(_ sender: Any) {
    }
    
    
    
    // MARK: - Navigation
    
    

}
