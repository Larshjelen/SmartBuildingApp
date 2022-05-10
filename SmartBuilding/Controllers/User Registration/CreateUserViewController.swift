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
    
    
    @IBOutlet weak var wrongPasswordText: UILabel!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var repeatPasswordView: UIView!
    @IBOutlet weak var emailView: UIView!
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var helpers = Utils()
    
    var styleAttributes = StyleAttributes()
    
    var ready : Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        repeatPassTextField.delegate = self
        
        setupKeyboardHiding()
        
        wrongPasswordText.isHidden = true
        
        emailView.layer.borderWidth = 0.5
        emailView.layer.cornerRadius = 8
        passwordView.layer.borderWidth = 0.5
        passwordView.layer.cornerRadius = 8
        repeatPasswordView.layer.borderWidth = 0.5
        repeatPasswordView.layer.cornerRadius = 8
        emailView.layer.borderColor = helpers.colorWithHexString(hexString: styleAttributes.backgroundDark).cgColor
        passwordView.layer.borderColor = helpers.colorWithHexString(hexString: styleAttributes.backgroundDark).cgColor
        repeatPasswordView.layer.borderColor = helpers.colorWithHexString(hexString: styleAttributes.backgroundDark).cgColor
      
     

    }
    

    
    func checkUserInputValid() {
       
       
       if ((passwordTextField.text?.isEmpty) != nil){
           passwordView.layer.borderColor = UIColor(ciColor: .red).cgColor
           ready = false
       }
       if passwordTextField.text!.count <= 4 && passwordTextField.text!.count > 1 {
           passwordView.layer.borderColor = helpers.colorWithHexString(hexString: styleAttributes.primary).cgColor
           ready = false
       }
       if repeatPassTextField.text != passwordTextField.text{
           repeatPasswordView.layer.borderColor = UIColor(ciColor: .red).cgColor
       
           wrongPasswordText.textColor = UIColor(ciColor: .red)
           wrongPasswordText.isHidden = false
           ready =  false
       }else {
           
           ready = true
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
        let newUser = User(context: self.context)
        newUser.email = emailTextField.text
        newUser.password = passwordTextField.text
        helpers.saveToDB(context: context)
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
