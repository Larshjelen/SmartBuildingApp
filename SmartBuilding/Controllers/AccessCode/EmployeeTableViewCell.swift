//
//  EmployeeTableViewCell.swift
//  SmartBuilding
//
//  Created by Lars Even Hjelen on 11/05/2022.
//

import UIKit

class EmployeeTableViewCell: UITableViewCell {


    @IBOutlet weak var employeeImage: UIImageView!

    @IBOutlet weak var employeeName: UILabel!

    @IBOutlet weak var employeeCompany: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        employeeImage.layer.masksToBounds = false
        employeeImage.layer.cornerRadius = employeeImage.frame.height/2
        employeeImage.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
