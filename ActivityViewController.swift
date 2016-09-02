//
//  ActivityViewController.swift
//  OZ
//
//  Created by val on 17/08/2016.
//  Copyright © 2016 Qing. All rights reserved.
//

import UIKit
import CoreData

class ActivityViewController: UIViewController {
    
    var thisActivity: ActivityModel!
    @IBOutlet var descLabel: UILabel!
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var linkBtn: UIButton!
    @IBOutlet var scrollView: UIScrollView!

    
    //Adopt protocol for delegate use
//    protocol addTrackDelegate {
//        func addTrack(t: Track)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        descLabel.text = thisActivity.desc
        
        let url = NSURL(string: thisActivity.picture!)
        let data = NSData(contentsOfURL: url!)
        //make sure your image in this url does exist, otherwise unwrap in a if let check
        imgView.image = UIImage(data: data!)
        // Do any additional setup after loading the view.
        if thisActivity.other == ""
        {
            linkBtn.enabled = false
            linkBtn.hidden = true
        }
        
    }
    
    // alert reference : https://github.com/codestergit/SweetAlert-iOS
    @IBAction func saveTrack(sender: AnyObject) {
        // save alert
        SweetAlert().showAlert("Have you done it?", subTitle: "You can view it in Track!", style: AlertStyle.Warning, buttonTitle:"Nope.", buttonColor:UIColor.colorFromRGB(0xD0D0D0) , otherButtonTitle:  "Yes. Got it!", otherButtonColor: UIColor.colorFromRGB(0xDD6B55))
        { (isOtherButton) -> Void in
            if isOtherButton == true {
                
                print("Try it later.", terminator: "")
            }
            else {
                TrackTableViewController.Variable.trackDate.addObject(NSDate())
                TrackTableViewController.Variable.tracks.addObject(self.thisActivity)
                
                SweetAlert().showAlert("Done!", subTitle: "Save to your track!", style: AlertStyle.Success)
            }
        }
        
    }
    
    
    @IBAction func openUrl(sender: AnyObject) {
        let url = NSURL(string: thisActivity.other!)
        UIApplication.sharedApplication().openURL(url!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //Navigate to news view page with selected row
        override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
//            if segue.identifier == "viewWeb" {
//                let viewController : ActivityWebViewController = segue.destinationViewController as! ActivityWebViewController
//                //get link of news for selected row
//                let url: String = thisActivity.other! as String
//                // get data by index and pass it to second view controller
//                viewController.url = url
//            }
            if segue.identifier == "activityMap" {
                let viewController : ActivityMapViewController = segue.destinationViewController as! ActivityMapViewController
                //get link of news for selected row
                // get data by index and pass it to second view controller
                viewController.activity = thisActivity
    
                
            }
        }
    
}
