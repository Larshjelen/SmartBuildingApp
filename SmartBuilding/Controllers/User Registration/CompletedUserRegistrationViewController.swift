//
//  CompletedUserRegistrationViewController.swift
//  SmartBuilding
//
//  Created by Ammar Khalil on 09/05/2022.
//

import UIKit
import CoreData

class CompletedUserRegistrationViewController: UIViewController {
    
    
    @IBOutlet weak var progressBarBorder: UIView!
    var helpers = Utils()
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.tintColor = .black
    }
    
    

    func updateUserInfo(){
        let request : NSFetchRequest<User> = User.fetchRequest()
        
        do{
            let user = try helpers.getContext().fetch(request)
            user.last?.isLoggedIn = true
            helpers.saveToDB()
        }catch {
            print(error.localizedDescription)
        }
        
    }
    
    // MARK: - Navigation

     @IBAction func createUserPressed(_ sender: UIButton) {
         updateUserInfo()
         self.performSegue(withIdentifier: "toHomeMap", sender: self)
     }


}
