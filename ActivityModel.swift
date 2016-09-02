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
    var lat: Double?
    var lng: Double?
    var type: String?
    var picture: String?
//    var transport: String?
//    var reason: String?
    var desc: String?
    var other: String?
    var star: Int?
    
    //empty constructor
    
    override init()
    {
        
    }
    
    //construct with @name, @address, @latitude, and @longitude parameters
    
    init(title: String, picture: String, desc: String, other: String, type: String, lat: Double, lng: Double, star: Int) {
        self.title = title
        self.picture = picture
        self.desc = desc
        self.other = other
        self.type = type
        self.lat = lat
        self.lng = lng
        self.star = star
    }
    
    
    //prints object's current state
    
    override var description: String {
        return "Name: \(title), Description: \(desc)"
        
    }
}
