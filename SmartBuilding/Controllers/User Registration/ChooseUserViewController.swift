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
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "ifEmployee", bundle: nil)
        let balanceViewController = storyBoard.instantiateViewController(withIdentifier: "balance") as! IfEmployeeViewController
        self.present(balanceViewController, animated: true, completion: nil)
    }
    
    @IBAction func guestBtnPressed(_ sender: Any) {
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
