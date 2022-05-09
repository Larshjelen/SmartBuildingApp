//
//  LogInViewController.swift
//  SmartBuilding
//
//  Created by Ammar Khalil on 09/05/2022.
//

import UIKit

class LogInViewController: UIViewController {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBOutlet weak var createUserPressed: UIView!
    @IBAction func logInPressed(_ sender: UIButton) {
    }
    
    @IBAction func backBtnPressed(_ sender: UIButton) {
    }
    
    @IBAction func createUserPressed(_ sender: UIButton) {
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
