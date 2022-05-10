//
//  PersonaliaViewController.swift
//  SmartBuilding
//
//  Created by Ammar Khalil on 09/05/2022.
//

import UIKit

class PersonaliaViewController: UIViewController {
    
    @IBOutlet weak var progressBarBorder: UIView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var nextBtn: UIButton!
    
    var helpers = Utils()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()

        loadUser()
    }
    
    
    
    @IBAction func nextBtnPressed(_ sender: Any) {
        
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "aboutCompany") as? AboutCompanyViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    
    
    func loadUser(){
        
        guard  let user = helpers.loadFromDB(context: context) else {
            
            return
        }
        
        print(user[0].password!)
    }

}
