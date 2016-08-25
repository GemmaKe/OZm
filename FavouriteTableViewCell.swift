//
//  FavouriteTableViewCell.swift
//  OZ
//
//  Created by val on 20/08/2016.
//  Copyright © 2016 Qing. All rights reserved.
//

import UIKit

class FavouriteTableViewCell: UITableViewCell {

    @IBOutlet var favImg: UIImageView!
    @IBOutlet var favLabel: UILabel!
    @IBOutlet var favSwitch: UISwitch!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
