//
//  MeetingRoomTableViewCell.swift
//  SmartBuilding
//
//  Created by Lars Even Hjelen on 12/05/2022.
//

import UIKit

class MeetingRoomTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var roomImage: UIImageView!
    
    @IBOutlet weak var roomName: UILabel!
    
    @IBOutlet weak var roomCapacity: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
