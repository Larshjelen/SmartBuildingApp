//
//  IfEmployeeViewController.swift
//  SmartBuilding
//
//  Created by Ammar Khalil on 09/05/2022.
//

import UIKit
import CoreData

class IfEmployeeViewController: UIViewController {
    
    var helpers = Utils()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //Navigation
    
    @IBAction func skipCreateUserPressed(_ sender: UIButton) {
        
        let newUser = User(context: helpers.getContext())
            newUser.isLoggedIn = false
           
            helpers.saveToDB()
        
    }
    
    @IBAction func CreateUserPressed(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "createUser") as? CreateUserViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
   

}
