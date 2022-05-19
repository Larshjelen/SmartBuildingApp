//
//  CreateUserViewController.swift
//  SmartBuilding
//
//  Created by Ammar Khalil on 09/05/2022.
//

import UIKit
import CoreData

class CreateUserViewController: UIViewController {
    
    
    @IBOutlet weak var ProgressBarBorder: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatPassTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var progress25: CustomProgressBar!
    @IBOutlet weak var progress50: CustomProgressBar!
    @IBOutlet weak var progress75: CustomProgressBar!
    @IBOutlet weak var progress100: CustomProgressBar!
    
    @IBOutlet weak var wrongPasswordText: UILabel!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var repeatPasswordView: UIView!
    @IBOutlet weak var emailView: UIView!
    
   
    
    var helpers = Utils()
    
    var styleAttributes = StyleAttributes()
    
    var ready : Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.tintColor = .black
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        repeatPassTextField.delegate = self
        
        setupKeyboardHiding()
    }

    
    func checkUserInputValid(){
       
        if passwordTextField.text?.count == 0{
           passwordView.layer.borderColor = UIColor(ciColor: .red).cgColor
            ready =  false
       }else {
           if passwordTextField.text!.count <= 4 && passwordTextField.text!.count > 1 {
               passwordView.layer.borderColor = helpers.colorWithHexString(hexString: styleAttributes.primary).cgColor
               ready = false
           } else {
               ready = true
           }
       }
        
    
        if repeatPassTextField.text!.count > 0 {
            if repeatPassTextField.text != passwordTextField.text{
                repeatPasswordView.layer.borderColor = UIColor(ciColor: .red).cgColor
                wrongPasswordText.textColor = UIColor(ciColor: .red)
                wrongPasswordText.isHidden = false
                
            }else {
                ready = true
            }
        }
    }
    
    
    private func setupKeyboardHiding() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
 
    @IBAction func nextBtnPressed(_ sender: Any) {
       checkUserInputValid()
        
        if ready{
            //Save entered info
            saveNewUser()
            //Navigate
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "personalia") as? PersonaliaViewController
             self.navigationController?.pushViewController(vc!, animated: true)
        }
    }
    

    func saveNewUser(){
        let newUser = User(context: helpers.getContext())
        let email = emailTextField.text
        let password = passwordTextField.text
        newUser.email = email
        newUser.password = password
        helpers.saveToDB()
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
