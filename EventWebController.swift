//
//  EventWebController.swift
//  OZ
//
//  Created by Le Minh Tuan on 30/08/2016.
//  Copyright © 2016 Qing. All rights reserved.
//

import UIKit

class EventWebController: UIViewController {
    var chosenEvent:event?
    @IBOutlet var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let URL = NSURL(string:(chosenEvent?.url)!)
        webView.loadRequest(NSURLRequest(URL : URL!))
        // Do any additional setup after loading the view.
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
