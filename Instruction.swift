//
//  Instruction.swift
//  OZ
//
//  Created by Le Minh Tuan on 25/08/2016.
//  Copyright © 2016 Qing. All rights reserved.
//

import UIKit

class Instruction: NSObject {
    var image:UIImage!
    var detail:String!
    override init()
    {
    }
    init(detail:String, image:String)
    {
        self.detail = detail
        self.image = UIImage(named: image)
    }
}
