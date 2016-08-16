//
//  PreferenceViewController.swift
//  OZ
//
//  Created by val on 11/08/2016.
//  Copyright © 2016 Qing. All rights reserved.
//

import UIKit

class PreferenceViewController: UIViewController {

    @IBOutlet var indoorLabel: UILabel!
    @IBOutlet var outdoorLabel: UILabel!
    @IBOutlet var artsLabel: UILabel!
    @IBOutlet var foodLabel: UILabel!
    @IBOutlet var sportsLabel: UILabel!
    var preference : [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.view.backgroundColor = UIColor(patternImage: UIImage(named:"M45-1.jpg")!)

        let imageView = UIImageView(frame: self.view.bounds)
        imageView.image = UIImage(named: "ssky2.jpg")//if its in images.xcassets
        self.view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
        
        indoorLabel.center.x = self.view.frame.width / 2
        indoorLabel.center.y = self.view.frame.height / 2
        outdoorLabel.center.x = self.view.frame.width / 2
        outdoorLabel.center.y = self.view.frame.height / 2
        artsLabel.center.x = self.view.frame.width / 2
        artsLabel.center.y = self.view.frame.height / 2
        foodLabel.center.x = self.view.frame.width / 2
        foodLabel.center.y = self.view.frame.height / 2
        sportsLabel.center.x = self.view.frame.width / 2
        sportsLabel.center.y = self.view.frame.height / 2
        
        UIView.animateWithDuration(1.0, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 3.5, options: [], animations: ({
            self.indoorLabel.center.x = self.view.frame.width / 2 - 40
            self.indoorLabel.center.y = self.view.frame.height / 2 - 40
            self.outdoorLabel.center.x = self.view.frame.width / 2 + 30
            self.outdoorLabel.center.y = self.view.frame.height / 2 - 45
            self.artsLabel.center.x = self.view.frame.width / 2 - 30
            self.artsLabel.center.y = self.view.frame.height / 2
            self.foodLabel.center.x = self.view.frame.width / 2 + 40
            self.foodLabel.center.y = self.view.frame.height / 2 + 10
            self.sportsLabel.center.x = self.view.frame.width / 2
            self.sportsLabel.center.y = self.view.frame.height / 2 + 40

        }), completion: nil)
        indoorLabel.userInteractionEnabled = true
        outdoorLabel.userInteractionEnabled = true
        artsLabel.userInteractionEnabled = true
        foodLabel.userInteractionEnabled = true
        sportsLabel.userInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(PreferenceViewController.handleTap(_:)))
        sportsLabel.addGestureRecognizer(gestureRecognizer)
        let gestureRecognizer1 = UITapGestureRecognizer(target: self, action: #selector(PreferenceViewController.handleTap1(_:)))
        indoorLabel.addGestureRecognizer(gestureRecognizer1)
        let gestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(PreferenceViewController.handleTap2(_:)))
        outdoorLabel.addGestureRecognizer(gestureRecognizer2)
        let gestureRecognizer3 = UITapGestureRecognizer(target: self, action: #selector(PreferenceViewController.handleTap3(_:)))
        artsLabel.addGestureRecognizer(gestureRecognizer3)
        let gestureRecognizer4 = UITapGestureRecognizer(target: self, action: #selector(PreferenceViewController.handleTap4(_:)))
        foodLabel.addGestureRecognizer(gestureRecognizer4)
        // Do any additional setup after loading the view.
        var swipeLeft = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGesture:")
        swipeLeft.direction = UISwipeGestureRecognizerDirection.Left
        self.view.addGestureRecognizer(swipeLeft)
    }
    
    func handleTap(gestureRecognizer: UIGestureRecognizer) {
        sportsLabel.textColor = UIColor.cyanColor()
        preference.append("sports")
    }
    
    func handleTap1(gestureRecognizer: UIGestureRecognizer) {
        indoorLabel.textColor = UIColor.grayColor()
        preference.append("indoor")
    }
    
    func handleTap2(gestureRecognizer: UIGestureRecognizer) {
        outdoorLabel.textColor = UIColor.darkGrayColor()
        preference.append("outdoor")
    }
    
    func handleTap3(gestureRecognizer: UIGestureRecognizer) {
        artsLabel.textColor = UIColor.lightGrayColor()
        preference.append("arts")
    }
    
    func handleTap4(gestureRecognizer: UIGestureRecognizer) {
        foodLabel.textColor = UIColor.yellowColor()
        preference.append("food")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated);
        super.viewWillDisappear(animated)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    
    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            switch swipeGesture.direction {
                
            case UISwipeGestureRecognizerDirection.Left:
                
                print("Swiped right")
                
                //change view controllers
                
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                
                let resultViewController = storyBoard.instantiateViewControllerWithIdentifier("main") as! MainTabController
                resultViewController.prefer = self.preference
                print(self.preference)
                self.presentViewController(resultViewController, animated:true, completion:nil)    
                
                
                
            default:
                break
            }
        }
    }

}
