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
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.tintColor = .black
    }
    
    

    func updateUserInfo(){
        let request : NSFetchRequest<User> = User.fetchRequest()
        
        do{
            let user = try context.fetch(request)
            user.last?.isLoggedIn = true
            helpers.saveToDB(context: context)
        }catch {
            print(error.localizedDescription)
        }
        
    }
    
    // MARK: - Navigation

     @IBAction func createUserPressed(_ sender: UIButton) {
         
         self.performSegue(withIdentifier: "toHomeMap", sender: self)
     }


}
