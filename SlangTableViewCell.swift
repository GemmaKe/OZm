//
//  SlangTableViewCell.swift
//  OZ
//
//  Created by val on 26/08/2016.
//  Copyright © 2016 Qing. All rights reserved.
//

import UIKit

class SlangTableViewCell: UITableViewCell {

    @IBOutlet var cellWord: UILabel!
    @IBOutlet var cellExplain: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
