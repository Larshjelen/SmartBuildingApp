//
//  GenerateCodeViewController.swift
//  SmartBuilding
//
//  Created by Lars Even Hjelen on 10/05/2022.
//

import UIKit

class GenerateCodeViewController: UINavigationController {
    
    
    @IBOutlet weak var firstTF: UITextField!
    
    @IBOutlet weak var secondTF: UITextField!
    
    @IBOutlet weak var thirdTF: UITextField!
    
    
    @IBOutlet weak var forthTF: UITextField!
    
    
    @IBOutlet weak var generateCodeBtn: SpinningButton!
    
    
    @IBOutlet weak var waitingText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        waitingText.isHidden = true
    }
    

    
    @IBAction func generateCodePressed(_ sender: SpinningButton) {
        
        generateCodeBtn.spinnerColor = .white
        generateCodeBtn.startAnimation()
        
        DispatchQueue.main.asyncAfter(deadline: .now()+4){
            
            self.generateCodeBtn.stopAnimation()
            self.generateCodeBtn.titleLabel?.text = "Fullfør"
            self.waitingText.isHidden = false
        }
    }
    
}
