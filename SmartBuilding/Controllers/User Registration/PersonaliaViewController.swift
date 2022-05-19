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
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()

        nameTextField.delegate = self
        lastNameTextField.delegate = self
        self.navigationController?.navigationBar.tintColor = .black
    }
    
    
    
    @IBAction func nextBtnPressed(_ sender: Any) {
        
       
       let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "aboutCompany") as? AboutCompanyViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    
    
    func updateUserInfo(){
        let request : NSFetchRequest<User> = User.fetchRequest()
        
        do{
            let user = try context.fetch(request)
            user.last?.name = nameTextField.text
            user.last?.lastName = lastNameTextField.text
            helpers.saveToDB(context: context)
        }catch {
            print(error.localizedDescription)
        }
        
    }
    
    func loadUser(){
        
        guard  let user = helpers.loadFromDB(context: context) else {
            
            return
        }
        
        print(user[0].password!)
        print(user[0].name!)
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
