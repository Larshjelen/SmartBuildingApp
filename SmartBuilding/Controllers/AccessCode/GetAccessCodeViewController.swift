//
//  GetAccessCodeViewController.swift
//  SmartBuilding
//
//  Created by Lars Even Hjelen on 18/05/2022.
//

import UIKit

class GetAccessCodeViewController: UIViewController {
    
    @IBOutlet weak var firstNumberField: UITextField!
    @IBOutlet weak var secondNumberField: UITextField!
    @IBOutlet weak var thirdNumberField: UITextField!
    @IBOutlet weak var fourthNumberField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func generateCodePressed(_ sender: UIButton) {
        firstNumberField.text = "3"
        secondNumberField.text = "7"
        thirdNumberField.text = "1"
        fourthNumberField.text = "2"
        NotificationCenter.default.post(name: .accessCode, object: nil)
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
