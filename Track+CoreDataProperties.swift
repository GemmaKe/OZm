//
//  Track+CoreDataProperties.swift
//  OZ
//
//  Created by val on 28/08/2016.
//  Copyright © 2016 Qing. All rights reserved.
//

import Foundation
import CoreData

extension Track {
    
    @NSManaged var title: String?
    @NSManaged var star: NSNumber?
    @NSManaged var dodate: NSDate?
    
    func addTrack(value: Track)
    {
        let re = self.mutableSetValueForKey("members")
        re.addObject(value)
        
    }
    
}

