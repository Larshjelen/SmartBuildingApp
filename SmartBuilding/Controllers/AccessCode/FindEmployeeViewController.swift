//
//  FindEmployeeViewController.swift
//  SmartBuilding
//
//  Created by Lars Even Hjelen on 10/05/2022.
//

import UIKit

class FindEmployeeViewController: UIViewController {

    @IBOutlet weak var searchEmployerTextField: UITextField!
    
    @IBOutlet weak var deleteSearchBtn: UIButton!
    
    @IBOutlet weak var searchTextBtn: UIButton!
    
    
    @IBOutlet weak var employeeTableView: UITableView!
    
    var employeeData : [Employee]!
    
    var filteredData : [Employee]!
    
    var utils = Utils()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        employeeTableView.register(UINib(nibName: K.employeeCellNibname, bundle: nil), forCellReuseIdentifier: K.employeeCellIdentifier)
        
        employeeTableView.dataSource = self
        employeeTableView.delegate = self
        
        if let data =  utils.loadJson(fileName: "Employers"){
            employeeData = data
        }
        searchEmployerTextField.addTarget(self, action: #selector(textSearchChange(_:)), for: .editingChanged)
        
        filteredData = employeeData
    }
    

    
    @IBAction func clearTextField(_ sender: UIButton) {
        
        searchEmployerTextField.text = nil
        filteredData = employeeData
        employeeTableView.reloadData()
    }
    
    @IBAction func textSearchChange(_ sender: UITextField) {
     
        if let text = searchEmployerTextField.text {
            
            if text.isEmpty{
                filteredData = employeeData
                employeeTableView.reloadData()
            }else {
                filteredData.removeAll{!$0.name.contains(text)}
                employeeTableView.reloadData()
            }
        }
        
    }
    
    

}

extension FindEmployeeViewController : UITableViewDataSource{
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return filteredData.count
    }
    
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.employeeCellIdentifier, for: indexPath) as! EmployeeTableViewCell
        
         cell.employeeName.text = filteredData[indexPath.row].name
         cell.employeeCompany.text = filteredData[indexPath.row].company
         cell.employeeImage.image = utils.urlToImage(StringImage: filteredData[indexPath.row].image)
        return cell
    }
    
}


extension FindEmployeeViewController : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let EmployeeDetailsVC = UIStoryboard.init(name: "AccessCode", bundle: Bundle.main).instantiateViewController(withIdentifier: "notifyEmployee") as? MeetingRoomsDetailsViewController
         self.navigationController?.pushViewController(EmployeeDetailsVC!, animated: true)
                let index = indexPath.row

                let employee = filteredData[index]
               print(employee)
       
      }
            
     }
