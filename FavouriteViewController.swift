//
//  FavouriteViewController.swift
//  OZ
//
//  Created by val on 20/08/2016.
//  Copyright © 2016 Qing. All rights reserved.
//

import UIKit

class FavouriteViewController: UIViewController {

    @IBOutlet var indoorSwitch: UISwitch!
    @IBOutlet var outdoorSwitch: UISwitch!
    @IBOutlet var sportsSwitch: UISwitch!
    @IBOutlet var foodSwitch: UISwitch!
    @IBOutlet var otherSwitch: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
   override func viewWillAppear(animated: Bool) {
        print(PreferenceViewController.Variables.preference)
        self.initSwitch()
        indoorSwitch.addTarget(self, action: #selector(FavouriteViewController.indoorChanged(_:)), forControlEvents: UIControlEvents.ValueChanged)
        outdoorSwitch.addTarget(self, action: "outdoorChanged:", forControlEvents: UIControlEvents.ValueChanged)
        sportsSwitch.addTarget(self, action: "sportsChanged:", forControlEvents: UIControlEvents.ValueChanged)
        foodSwitch.addTarget(self, action: "foodChanged:", forControlEvents: UIControlEvents.ValueChanged)
        otherSwitch.addTarget(self, action: "otherChanged:", forControlEvents: UIControlEvents.ValueChanged)
        // Do any additional setup after loading the view.
    }
    
    func indoorChanged(mySwitch: UISwitch) {
        if mySwitch.on == true {
            PreferenceViewController.Variables.preference.append("indoor")
        } else {
        PreferenceViewController.Variables.preference.removeAtIndex(PreferenceViewController.Variables.preference.indexOf("indoor")!)
        }
        print(PreferenceViewController.Variables.preference)

        // Do something
    }
    
    func outdoorChanged(mySwitch: UISwitch) {
        if mySwitch.on == true {
            PreferenceViewController.Variables.preference.append("outdoor")
        } else {
            PreferenceViewController.Variables.preference.removeAtIndex(PreferenceViewController.Variables.preference.indexOf("outdoor")!)
        }
        print(PreferenceViewController.Variables.preference)

        // Do something
    }
    func sportsChanged(mySwitch: UISwitch) {
        if mySwitch.on == true {
            PreferenceViewController.Variables.preference.append("sports")
        } else {
            PreferenceViewController.Variables.preference.removeAtIndex(PreferenceViewController.Variables.preference.indexOf("sports")!)
        }
        print(PreferenceViewController.Variables.preference)

        // Do something
    }
    
    func foodChanged(mySwitch: UISwitch) {
        if mySwitch.on == true {
            PreferenceViewController.Variables.preference.append("food")
        } else {
            PreferenceViewController.Variables.preference.removeAtIndex(PreferenceViewController.Variables.preference.indexOf("food")!)
        }
        print(PreferenceViewController.Variables.preference)

        // Do something
    }
    
    func otherChanged(mySwitch: UISwitch) {
        if mySwitch.on == true {
            PreferenceViewController.Variables.preference.append("others")
        } else {
            PreferenceViewController.Variables.preference.removeAtIndex(PreferenceViewController.Variables.preference.indexOf("others")!)
        }
        print(PreferenceViewController.Variables.preference)

        // Do something
    }
    
    func initSwitch() {
        sportsSwitch.on = false
        outdoorSwitch.on = false
        indoorSwitch.on = false
        foodSwitch.on = false
        otherSwitch.on = false
        
        for item in PreferenceViewController.Variables.preference {
            switch item {
            case "sports":
                sportsSwitch.on = true
            case "outdoor":
                outdoorSwitch.on = true
            case "indoor":
                indoorSwitch.on = true
            case "food":
                foodSwitch.on = true
            case "others":
                otherSwitch.on = true
            default:
                break
                
            }
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
