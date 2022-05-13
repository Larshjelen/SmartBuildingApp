//
//  MeetingRoomsDetailsViewController.swift
//  SmartBuilding
//
//  Created by Lars Even Hjelen on 13/05/2022.
//

import UIKit

class MeetingRoomsDetailsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func choosePressed(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "MeetingRoom", bundle: Bundle.main).instantiateViewController(withIdentifier: "bookingSummary") as? PersonaliaViewController
         self.navigationController?.pushViewController(vc!, animated: true)
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
