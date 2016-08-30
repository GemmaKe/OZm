//
//  Slang.swift
//  OZ
//
//  Created by val on 26/08/2016.
//  Copyright © 2016 Qing. All rights reserved.
//

import UIKit

class Slang: NSObject {
    var word: String?
    var explain: String?
    
    //empty constructor
    
    override init()
    {
        
    }
    
    //construct with @name, @address, @latitude, and @longitude parameters
    
    init(word: String, explain: String) {
        self.word = word
        self.explain = explain
    }
    


}
