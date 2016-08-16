//
//  MainTabController.swift
//  OZ
//
//  Created by val on 15/08/2016.
//  Copyright © 2016 Qing. All rights reserved.
//

import UIKit

class MainTabController: UITabBarController {
    var prefer : [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        print("re")
        print(prefer)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}
