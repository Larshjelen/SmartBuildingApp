//
//  SearchCellTableViewCell.swift
//  SmartBuilding
//
//  Created by Ammar Khalil on 17/05/2022.
//

import UIKit

class SearchCell: UITableViewCell {
    
    
    @IBOutlet weak var roomName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
