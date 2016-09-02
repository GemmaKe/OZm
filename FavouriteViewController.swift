//
//  FavouriteViewController.swift
//  OZ
//
//  Created by val on 20/08/2016.
//  Copyright © 2016 Qing. All rights reserved.
//

import UIKit

class FavouriteViewController: UIViewController {
    
    @IBOutlet var indoorSlider: UISlider!
    @IBOutlet var outdoorSlider: UISlider!
    @IBOutlet var sportsSlider: UISlider!
    @IBOutlet var foodSlider: UISlider!
    @IBOutlet var sightseeingSlider: UISlider!
    
    override func viewDidLoad() {
        updatePreference()
        super.viewDidLoad()
    }
    
    @IBAction func save(sender: AnyObject) {
        User.likeIndoor = Int(indoorSlider.value)
        User.likeOutdoor = Int(outdoorSlider.value)
        User.likeSport = Int(sportsSlider.value)
        User.likeFood = Int(foodSlider.value)
        User.likeSightSeeing = Int(sightseeingSlider.value)
        self.navigationController!.popToRootViewControllerAnimated(true)
    }
    
    
    func initSwitch() {
        updatePreference()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updatePreference()
    {
        indoorSlider.setValue(Float(User.likeIndoor), animated: false)
        outdoorSlider.setValue(Float(User.likeOutdoor), animated: false)
        sportsSlider.setValue(Float(User.likeSport), animated: false)
        foodSlider.setValue(Float(User.likeFood), animated: false)
        sightseeingSlider.setValue(Float(User.likeSightSeeing), animated: false)
        
    }
    
}
