//
//  ActivityViewController.swift
//  OZ
//
//  Created by val on 17/08/2016.
//  Copyright © 2016 Qing. All rights reserved.
//

import UIKit

class ActivityViewController: UIViewController {

    var thisActivity: ActivityModel!
//    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descLabel: UILabel!
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var linkBtn: UIButton!
    
//    @IBOutlet var scrollView: UIScrollView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        descLabel.text = "\(thisActivity.desc!)"
        descLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        descLabel.numberOfLines = 20
        let url = NSURL(string: thisActivity.picture!)
        let data = NSData(contentsOfURL: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check
        imgView.image = UIImage(data: data!)
        // Do any additional setup after loading the view.
        if thisActivity.other == "" {
            linkBtn.enabled = false
            linkBtn.hidden = true
        }
        let button = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Bordered, target: self, action: "goBack")
        self.navigationItem.leftBarButtonItem = button
        
    }
    
    func goBack()
    {
        self.navigationController?.popViewControllerAnimated(true)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //Navigate to news view page with selected row
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "viewWeb" {
            let viewController : ActivityWebViewController = segue.destinationViewController as! ActivityWebViewController
            //get link of news for selected row
            let url: String = thisActivity.other! as String
            // get data by index and pass it to second view controller
            viewController.url = url
        }
        if segue.identifier == "activityMap" {
            let viewController : ActivityMapViewController = segue.destinationViewController as! ActivityMapViewController
            //get link of news for selected row
            let searchTitle: String = thisActivity.title! as String
            // get data by index and pass it to second view controller
            viewController.searchTitle = searchTitle

            
        }
    }

}
