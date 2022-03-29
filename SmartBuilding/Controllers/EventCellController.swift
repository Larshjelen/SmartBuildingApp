//
//  EventCell.swift
//  SmartBuilding
//
//  Created by Ammar Khalil on 21/03/2022.
//

import UIKit

class EventCell: UITableViewCell {

    @IBOutlet weak var eventName: UILabel!
    
    
    @IBOutlet weak var eventNameView: UIView!
    
    @IBOutlet weak var eventImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        eventNameView.layer.cornerRadius = eventNameView.frame.size.height / 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
