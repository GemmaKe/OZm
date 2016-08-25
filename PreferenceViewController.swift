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
    
    @IBOutlet var swipeHint: UIImageView!
//    var preference : [String] = []
    @IBOutlet var arrowVIew: UIView!
    
    struct Variables {
        static var preference:[String] = []
    }
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.view.backgroundColor = UIColor(patternImage: UIImage(named:"M45-1.jpg")!)

        let imageView = UIImageView(frame: self.view.bounds)
        imageView.image = UIImage(named: "ssky2.jpg")//if its in images.xcassets
        self.view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
        
        self.labelInsert()
        swipeHint.image = UIImage(named: "arrow.png")
        self.playAnimation()
        // Do any additional setup after loading the view.
        var swipeLeft = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGesture:")
        swipeLeft.direction = UISwipeGestureRecognizerDirection.Left
        self.view.addGestureRecognizer(swipeLeft)
    }
    
    func labelInsert() {
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
            self.indoorLabel.center.x = self.view.frame.width / 2 - 50
            self.indoorLabel.center.y = self.view.frame.height / 2 - 50
            self.outdoorLabel.center.x = self.view.frame.width / 2 + 40
            self.outdoorLabel.center.y = self.view.frame.height / 2 - 50
            self.artsLabel.center.x = self.view.frame.width / 2 - 40
            self.artsLabel.center.y = self.view.frame.height / 2
            self.foodLabel.center.x = self.view.frame.width / 2 + 50
            self.foodLabel.center.y = self.view.frame.height / 2 + 20
            self.sportsLabel.center.x = self.view.frame.width / 2
            self.sportsLabel.center.y = self.view.frame.height / 2 + 50
            
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

    }
    
    func playAnimation() {
//       for var i = 0; i >= 0; i += 1 {
//            //先将数字块大小置为原始尺寸的 1/10
//            arrowVIew.layer.setAffineTransform(CGAffineTransformMakeScale(0.1,0.1))
//            
//            //设置动画效果，动画时间长度 1 秒。
//            UIView.animateWithDuration(1, delay:0.01, options:UIViewAnimationOptions.TransitionNone, animations:
//                {
//                    ()-> Void in
//                    self.arrowVIew.layer.setAffineTransform(CGAffineTransformMakeScale(1,1))
//                },
//                                       completion:{
//                                        (finished:Bool) -> Void in
//                                        UIView.animateWithDuration(0.08, animations:{
//                                            ()-> Void in
//                                            self.arrowVIew.layer.setAffineTransform(CGAffineTransformIdentity)
//                                        })
//            })

        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(1.5) //设置动画时间
        UIView.setAnimationRepeatAutoreverses(true)
        UIView.setAnimationRepeatCount(10000)
        self.swipeHint.transform = CGAffineTransformScale(self.swipeHint.transform, 1.5 ,1.5)
        UIView.commitAnimations()
        
    }
    
    func handleTap(gestureRecognizer: UIGestureRecognizer) {
        sportsLabel.textColor = UIColor.cyanColor()
        PreferenceViewController.Variables.preference.append("sports")
    }
    
    func handleTap1(gestureRecognizer: UIGestureRecognizer) {
        indoorLabel.textColor = UIColor.grayColor()
        PreferenceViewController.Variables.preference.append("indoor")
    }
    
    func handleTap2(gestureRecognizer: UIGestureRecognizer) {
        outdoorLabel.textColor = UIColor.darkGrayColor()
        PreferenceViewController.Variables.preference.append("outdoor")
    }
    
    func handleTap3(gestureRecognizer: UIGestureRecognizer) {
        artsLabel.textColor = UIColor.lightGrayColor()
        PreferenceViewController.Variables.preference.append("others")
    }
    
    func handleTap4(gestureRecognizer: UIGestureRecognizer) {
        foodLabel.textColor = UIColor.yellowColor()
        PreferenceViewController.Variables.preference.append("food")
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
                self.presentViewController(resultViewController, animated:true, completion:nil)    
                
                
                
            default:
                break
            }
        }
    }

}
