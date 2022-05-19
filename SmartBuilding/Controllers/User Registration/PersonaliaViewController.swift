//
//  PersonaliaViewController.swift
//  SmartBuilding
//
//  Created by Ammar Khalil on 09/05/2022.
//

import UIKit
import CoreData

class PersonaliaViewController: UIViewController {
    
    @IBOutlet weak var progressBarBorder: UIView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var nextBtn: UIButton!
    
    var helpers = Utils()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameTextField.delegate = self
        lastNameTextField.delegate = self
        self.navigationController?.navigationBar.tintColor = .black
        
        
    }
    
    
    
    @IBAction func nextBtnPressed(_ sender: Any) {
        
       updateUserInfo()
        
       let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "aboutCompany") as? AboutCompanyViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    
    
    func updateUserInfo(){
        let request : NSFetchRequest<User> = User.fetchRequest()
        
        do{
            let user = try helpers.getContext().fetch(request)
            let name = nameTextField.text
            let lastName = lastNameTextField.text
            user.last?.name = name
            user.last?.lastName = lastName
            helpers.saveToDB()
        }catch {
            print(error.localizedDescription)
        }
        
    }
    

    
 

}

// MARK: Keyboard
extension PersonaliaViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextField.endEditing(true)
        lastNameTextField.endEditing(true)
        return true
        
    }
}
