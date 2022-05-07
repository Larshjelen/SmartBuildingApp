//
//  EventCell.swift
//  SmartBuilding
//
//  Created by Ammar Khalil on 21/03/2022.
//

import UIKit

class EventCell: UITableViewCell {

    @IBOutlet weak var cellContentView: UIView!
    @IBOutlet weak var evenCellStackView: UIStackView!
    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var timeView: UIView!
    
    
    @IBOutlet weak var eventNameView: UIView!
    
    @IBOutlet weak var eventImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //cellContentView.layer.cornerRadius = cellContentView.frame.size.height / 4.5
       // eventNameView.layer.cornerRadius = eventNameView.frame.size.height / 5
        self.eventImage.roundCorners([.layerMaxXMinYCorner, .layerMinXMinYCorner], radius: 20.0, borderColor: UIColor.green, borderWidth: 0)
        self.timeView.roundCorners([.layerMinXMaxYCorner, .layerMaxXMaxYCorner], radius: 20.0, borderColor: UIColor.green, borderWidth: 0)
        layoutSubviews()
        

        //timeView.layer.masksToBounds = false
        evenCellStackView.layer.shadowOffset = CGSize(width: 0,height: 0)
        evenCellStackView.layer.shadowColor = UIColor.black.cgColor
        evenCellStackView.layer.shadowOpacity = 0.23
        evenCellStackView.layer.shadowRadius = 4
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
          super.layoutSubviews()
          let bottomSpace: CGFloat = 30.0 // Let's assume the space you want is 10
          self.contentView.frame = self.contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: bottomSpace, right: 0))
     }
    
    
    
}

extension UIView {

   func roundCorners(_ corners: CACornerMask, radius: CGFloat, borderColor: UIColor, borderWidth: CGFloat) {
       self.layer.maskedCorners = corners
       self.layer.cornerRadius = radius
       self.layer.borderWidth = borderWidth
       self.layer.borderColor = borderColor.cgColor
    
   }

 }
