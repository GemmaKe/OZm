//
//  EventViewCell.swift
//  OZ
//
//  Created by Le Minh Tuan on 30/08/2016.
//  Copyright © 2016 Qing. All rights reserved.
//

import UIKit

class EventViewCell: UITableViewCell {
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var labelView: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
