//
//  AboutCompanyViewController.swift
//  SmartBuilding
//
//  Created by Ammar Khalil on 09/05/2022.
//

import UIKit
import CoreData
class AboutCompanyViewController: UIViewController {
    
    @IBOutlet weak var progressBarBorder: UIView!
    
    
    @IBOutlet weak var companyNameTextField: UITextField!
    
    
    @IBOutlet weak var positionTextField: UITextField!
    
    
    @IBOutlet weak var workHereBtn: CheckButton!
    
    @IBOutlet weak var guestBtn: CheckButton!
    
    @IBOutlet weak var isEmployeeCheckMark: CircleImageView!
    
    @IBOutlet weak var isGuestCheckMark: CircleImageView!
    
    var helpers = Utils()
    var isGuest = false
    var isEmployee = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        companyNameTextField.delegate = self
        positionTextField.delegate = self
        self.navigationController?.navigationBar.tintColor = .black
    }
    
    
    
    @IBAction func workHerePressed(_ sender: UIButton) {
        
        guestBtn.isEnabled = false
        isEmployeeCheckMark.backgroundColor = .green
        isEmployee = true
        
    }
    
    
    @IBAction func guestPressed(_ sender: UIButton) {
        workHereBtn.isEnabled = false
        isGuestCheckMark.backgroundColor = .green
        isGuest = true
    }
    
    @IBAction func nextBtnPressed(_ sender: UIButton) {
        updateUserInfo()
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "completed") as? CompletedUserRegistrationViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func updateUserInfo(){
        let request : NSFetchRequest<User> = User.fetchRequest()
        
        do{
            let user = try helpers.getContext().fetch(request)
            user.last?.company = companyNameTextField.text
            user.last?.position = positionTextField.text
            user.last?.isGuest = isGuest
            user.last?.isEmployee = isEmployee
            helpers.saveToDB()
        }catch {
            print(error.localizedDescription)
        }
        
    }
    


}

// MARK: Keyboard
extension AboutCompanyViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        companyNameTextField.endEditing(true)
        positionTextField.endEditing(true)
        return true
        
    }
}
