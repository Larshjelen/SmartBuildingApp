//
//  EventCell.swift
//  SmartBuilding
//
//  Created by Ammar Khalil on 21/03/2022.
//

import UIKit

class EventCell: UITableViewCell {

    @IBOutlet weak var eventView: UIView!
    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var eventName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
