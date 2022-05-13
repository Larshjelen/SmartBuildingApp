//
//  GuestInformation.swift
//  SmartBuilding
//
//  Created by Lars Even Hjelen on 13/05/2022.
//

import Foundation
import UIKit

class GuestInformationViewController: UIViewController {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func sendInvitePressed(_ sender: UIButton) {
        
        let vc = UIStoryboard.init(name: "Invite", bundle: Bundle.main).instantiateViewController(withIdentifier: "inviteSent") as? InviteSentViewController
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
}
