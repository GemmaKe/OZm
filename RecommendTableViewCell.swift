//
//  RecommendTableViewCell.swift
//  OZ
//
//  Created by val on 15/08/2016.
//  Copyright © 2016 Qing. All rights reserved.
//

import UIKit

class RecommendTableViewCell: UITableViewCell {
    @IBOutlet var rcmdTitle: UILabel!
    @IBOutlet var rcmdImage: UIImageView!
    @IBOutlet var rcmdDesc: UILabel!
    @IBOutlet var star1: UIImageView!
    @IBOutlet var star2: UIImageView!
    @IBOutlet var star3: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
