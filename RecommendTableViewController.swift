//
//  RecommendTableViewController.swift
//  OZ
//
//  Created by val on 15/08/2016.
//  Copyright © 2016 Qing. All rights reserved.
//

import UIKit
import Foundation
import SystemConfiguration

class RecommendTableViewController: UITableViewController {
    
//    var prefer : [String] = []
    var allRecomm: NSMutableArray = []
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    //Update tableView everytime user click back
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if isConnectedToNetwork() {
            self.searchNewData()
        }
        else {
            // create the alert
            let alert = UIAlertController(title: "Network Error", message: "Please check network.", preferredStyle: UIAlertControllerStyle.Alert)
            
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            
            // show the alert
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.allRecomm.count
    }
    
    //Check whether network is available
    func isConnectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(sizeofValue(zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(&zeroAddress) {
            SCNetworkReachabilityCreateWithAddress(kCFAllocatorDefault, UnsafePointer($0))
        }
        
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }
        
        let isReachable = flags == .Reachable
        let needsConnection = flags == .ConnectionRequired
        
        return isReachable && !needsConnection
        
    }


    func searchNewData() {
        self.allRecomm.removeAllObjects()
        //Create json request
        let requestURL: NSURL = NSURL(string: "http://13.73.194.192/service.php")!
        let urlRequest: NSMutableURLRequest = NSMutableURLRequest(URL: requestURL)
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithRequest(urlRequest) {
            (data, response, error) -> Void in
            //Get http response and if status is ok, read content of it
            let httpResponse = response as! NSHTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            if (statusCode == 200) {
                do{
                    //Get news item one layer by one layer
                    let json = try NSJSONSerialization.JSONObjectWithData(data!, options:.AllowFragments)
//                    let query = json.objectForKey("query") as! NSDictionary
//                    let result = query.objectForKey("results") as! NSDictionary
                    let items = json as! NSArray
                    self.readJson(items)
                }catch {
                    print("Error with Json: \(error)")
                }
                self.tableView.reloadData()
                
            }
        }
        task.resume()
        
    }

    //Transfer JSON content to activity object and save in an array
    func readJson(items: NSArray) {
        let indoorAct: NSMutableArray = []
        let outdoorAct: NSMutableArray = []
        let sportsAct: NSMutableArray = []
        let foodAct: NSMutableArray = []
        let others: NSMutableArray = []
        //Duplicate title, description, link and image url from json response to self array
        for activity in (items as NSArray )
        {
            //Get title
            let title = activity["name"]! as! String
            let desc = activity["description"]! as! String
            let type = activity["type"]! as! String
            let other = activity["other"]! as! String
            if !other.isEmpty {
                let other = " "
            }
            let picture = activity["picture"] as! String
            if picture.isEmpty {
                let picture = "maxresdefault.jpg"
            }

            //New a news with received data
            let a = ActivityModel(title: title, picture: picture, desc: desc, other: other, type: type)
//            let a = ActivityModel(title: title, address: address, desc: desc)
            //Add news into array
            switch type {
            case "sports":
                sportsAct.addObject(a)
            case "outdoor":
                outdoorAct.addObject(a)
            case "indoor":
                indoorAct.addObject(a)
            case "sightseeing":
                others.addObject(a)
            case "food":
                foodAct.addObject(a)
            default:
                break
            }
        }
        for item in PreferenceViewController.Variables.preference {
            //Add news into array
            switch item {
            case "sports":
                self.allRecomm.addObjectsFromArray(sportsAct as [AnyObject])
            case "outdoor":
                self.allRecomm.addObjectsFromArray(outdoorAct as [AnyObject])
            case "indoor":
                self.allRecomm.addObjectsFromArray(indoorAct as [AnyObject])
            case "food":
                self.allRecomm.addObjectsFromArray(foodAct as [AnyObject])
            case "others":
                self.allRecomm.addObjectsFromArray(others as [AnyObject])
            default: break
            
                
            }

        }
        if PreferenceViewController.Variables.preference.isEmpty {
            self.allRecomm.addObjectsFromArray(outdoorAct as [AnyObject])
            self.allRecomm.addObjectsFromArray(indoorAct as [AnyObject])
            self.allRecomm.addObjectsFromArray(foodAct as [AnyObject])
            self.allRecomm.addObjectsFromArray(sportsAct as [AnyObject])
            self.allRecomm.addObjectsFromArray(others as [AnyObject])
        }
        
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //Set cell identifier with the same as layout
        let cellIdentifier = "recommCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! RecommendTableViewCell
        
        // Configure the cell with title, description and image
        let a:ActivityModel = allRecomm[indexPath.row] as! ActivityModel
        cell.rcmdTitle.text = "\(a.title!)"
        //Make label auto wripped
        cell.rcmdTitle.lineBreakMode = NSLineBreakMode.ByWordWrapping
        
        let url = NSURL(string: a.picture!)
        let data = NSData(contentsOfURL: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check
        cell.rcmdImage!.image = UIImage(data: data!)

        return cell
        
    }

    //Navigate to activity view page with selected row
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "activityDetails" {
            let viewController : ActivityViewController = segue.destinationViewController as! ActivityViewController
            //get link of news for selected row
            
            
            let backBtn = UIBarButtonItem()
            backBtn.title = "Back"
            navigationItem.backBarButtonItem = backBtn
            
            let index = self.tableView.indexPathForSelectedRow!.row
            let selectedActivity: ActivityModel = self.allRecomm[index] as! ActivityModel
            viewController.title = self.allRecomm[index].title
            // get data by index and pass it to second view controller
            viewController.thisActivity = selectedActivity
        }
    }

    
}
