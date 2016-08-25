//
//  ActivityModel.swift
//  OZ
//
//  Created by val on 17/08/2016.
//  Copyright © 2016 Qing. All rights reserved.
//

import UIKit

class ActivityModel: NSObject {
    //properties
    
    var title: String?
//    var address: String?
//    var latitude: String?
//    var longitude: String?
    var type: String?
    var picture: String?
//    var transport: String?
//    var reason: String?
    var desc: String?
    var other: String?
    
    //empty constructor
    
    override init()
    {
        
    }
    
    //construct with @name, @address, @latitude, and @longitude parameters
    
    init(title: String, picture: String, desc: String, other: String, type: String) {
        self.title = title
        self.picture = picture
        self.desc = desc
        self.other = other
        self.type = type
    }
    
    
    //prints object's current state
    
    override var description: String {
        return "Name: \(title), Description: \(desc)"
        
    }
}
