//
//  TrackTableViewCell.swift
//  OZ
//
//  Created by val on 28/08/2016.
//  Copyright © 2016 Qing. All rights reserved.
//

import UIKit

class TrackTableViewCell: UITableViewCell {

    @IBOutlet var dodate: UILabel!
    @IBOutlet var title: UILabel!
    @IBOutlet var heart1: UIImageView!
    @IBOutlet var heart2: UIImageView!
    @IBOutlet var heart3: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
