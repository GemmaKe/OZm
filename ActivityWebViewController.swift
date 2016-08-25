//
//  ActivityWebViewController.swift
//  OZ
//
//  Created by val on 19/08/2016.
//  Copyright © 2016 Qing. All rights reserved.
//

import UIKit

class ActivityWebViewController: UIViewController {

    @IBOutlet var webView: UIWebView!
    var url: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Load web with certain url
        let webUrl = NSURL (string: url)
        let requestObj = NSURLRequest(URL: webUrl!)
        webView.loadRequest(requestObj)
        self.view.addSubview(webView)
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
