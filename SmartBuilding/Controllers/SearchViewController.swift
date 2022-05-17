//
//  SearchViewController.swift
//  SmartBuilding
//
//  Created by Lars Even Hjelen on 17/05/2022.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate {


    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        searchBar.delegate = self
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        let searchBuildingVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "searchBuilding") as? SearchBuildingViewController
         self.navigationController?.pushViewController(searchBuildingVC!, animated: true)
        return false
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
