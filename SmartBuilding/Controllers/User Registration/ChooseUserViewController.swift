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
        
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "welcome-employee") as? IfEmployeeViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func guestBtnPressed(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "mapView") as? MapViewController
        self.present(vc!, animated: true)
    }
    
    
    
    // MARK: - Navigation
    
    

}
