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
    
  
    @IBOutlet weak var nextButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        repeatPassTextField.delegate = self
        
        setupKeyboardHiding()
        
    }
    
    private func setupKeyboardHiding() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
 
    
    @IBAction func nextBtnPressed(_ sender: Any) {
        
//        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "personalia") as? PersonaliaViewController
//        self.navigationController?.pushViewController(vc!, animated: true)
        
        print(emailTextField.text!)
    }
    


}




// MARK: Keyboard
extension CreateUserViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailTextField.endEditing(true)
        passwordTextField.endEditing(true)
        repeatPassTextField.endEditing(true)
        return true
        
    }
  
    
    @objc func keyboardWillShow(sender: NSNotification) {
       
        if repeatPassTextField.isEditing && view.frame.origin.y > -200{
            
            view.frame.origin.y = view.frame.origin.y - 200
        }
        
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        
        view.frame.origin.y = 0
    }
}
