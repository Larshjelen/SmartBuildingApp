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
    
    var isExpand : Bool = false
    @IBOutlet weak var nextButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        repeatPassTextField.delegate = self
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardApear), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDisapear), name: UIResponder.keyboardWillShowNotification, object: nil)
        
    }
    
    
    @obj func keyboardApear(){
        
        if !isExpand{
            self.scrollView
        }
    }
    
    @IBAction func nextBtnPressed(_ sender: Any) {
        
//        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "personalia") as? PersonaliaViewController
//        self.navigationController?.pushViewController(vc!, animated: true)
        
        print(emailTextField.text!)
    }
    


}


extension CreateUserViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       
        emailTextField.endEditing(true)
        passwordTextField.endEditing(true)
        
        return true
    }
    
}
