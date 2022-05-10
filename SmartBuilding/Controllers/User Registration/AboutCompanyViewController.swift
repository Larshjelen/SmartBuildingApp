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
    
    
    @IBOutlet weak var nextBtn: UIButton!
    
    var helpers = Utils()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func nextBtnPressed(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "completed") as? CompletedUserRegistrationViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func updateUserInfo(){
        let request : NSFetchRequest<User> = User.fetchRequest()
        
        do{
            let user = try context.fetch(request)
            user.first?.company = companyNameTextField.text
            user.first?.position = positionTextField.text
            helpers.saveToDB(context: context)
        }catch {
            print(error.localizedDescription)
        }
        
    }

}
