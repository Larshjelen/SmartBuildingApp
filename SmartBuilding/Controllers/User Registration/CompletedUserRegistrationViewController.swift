//
//  CompletedUserRegistrationViewController.swift
//  SmartBuilding
//
//  Created by Ammar Khalil on 09/05/2022.
//

import UIKit

class CompletedUserRegistrationViewController: UIViewController {
    
    
    @IBOutlet weak var progressBarBorder: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func backbtnPressed(_ sender: UIButton) {
        
        self.performSegue(withIdentifier: "fromUserCreatedToAboutCompany", sender: self)
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