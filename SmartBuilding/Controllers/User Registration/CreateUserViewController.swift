//
//  CreateUserViewController.swift
//  SmartBuilding
//
//  Created by Ammar Khalil on 09/05/2022.
//

import UIKit

class CreateUserViewController: UIViewController {
    
    
    @IBOutlet weak var ProgressBarBorder: UIView!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var repeatPassTextField: UITextField!
    
    
    @IBOutlet weak var nextButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func nextBtnPressed(_ sender: Any) {
        
        self.performSegue(withIdentifier: "personalia", sender: self)
    }
    
    @IBAction func BackBtnPressed(_ sender: UIButton) {
        
        self.performSegue(withIdentifier: "fromCreateToEmployee", sender: self)
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
