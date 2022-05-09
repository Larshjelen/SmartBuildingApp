//
//  IfEmployeeViewController.swift
//  SmartBuilding
//
//  Created by Ammar Khalil on 09/05/2022.
//

import UIKit

class IfEmployeeViewController: UIViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func skipCreateUserPressed(_ sender: UIButton) {
    }
    
    //Navigation
    @IBAction func CreateUserPressed(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "createUser") as? CreateUserViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
   

}
