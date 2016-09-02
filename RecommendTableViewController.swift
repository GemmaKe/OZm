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
//import ImageLoader

class RecommendTableViewController: UITableViewController {
    let rate1: NSMutableArray = []
    let rate2: NSMutableArray = []
    let rate3: NSMutableArray = []
    let rate4: NSMutableArray = []
    let rate5: NSMutableArray = []
    let rate6: NSMutableArray = []
    let rate7: NSMutableArray = []
    let rate8: NSMutableArray = []
    var connected = false
    var allRecomm: NSMutableArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if isConnectedToNetwork() {
            self.searchNewData()
            connected = true
        }
        else {
            // create the alert for user in case there is no Internet connection
            let alert = UIAlertController(title: "There is no Internet connection", message: "Please go to setting > Wi-Fi/Cellular  or to check your connection again. \n Try: \n - Reconnecting to wifi \n - Refresh cellular data  ", preferredStyle: UIAlertControllerStyle.Alert)
            let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
            
            alert.addAction(action)
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    //Reload tableView everytime user click back
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if (!connected && isConnectedToNetwork())
        {
            self.searchNewData()
            connected = true
        }
        self.updateActivity()
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
                    
                    let items = json as! NSArray
                    self.readJson(items)
                    self.updateActivity()
                    
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
        var i = 1
        //Duplicate title, description, link and image url from json response to self array
        for activity in (items as NSArray )
        {
            //Get title
            let title = activity["name"]! as! String
            let desc = activity["description"]! as! String
            let type = activity["type"]! as! String
            let lat = Double(activity["latitude"]! as! String)!
            let lng = Double(activity["longitude"]! as! String)!
            let other = activity["other"]! as! String
            if !other.isEmpty {
                let other = " "
            }
            let picture = activity["picture"] as! String
            if picture.isEmpty {
                let picture = "maxresdefault.jpg"
            }
            let star = Int(activity["star"] as! String)!
            
            //New a news with received data
            let a = ActivityModel(title: title, picture: picture, desc: desc, other: other, type: type, lat: lat, lng: lng, star: star)
            //            allRecomm.addObject(a)
            insertSubarray(a)
            
            let i = i + 1
            if i == items.count {
                combineArray()
            }
        }
    }
    
    func combineArray() {
        allRecomm.removeAllObjects()
        self.allRecomm.addObjectsFromArray(rate8 as [AnyObject])
        self.allRecomm.addObjectsFromArray(rate7 as [AnyObject])
        self.allRecomm.addObjectsFromArray(rate6 as [AnyObject])
        self.allRecomm.addObjectsFromArray(rate5 as [AnyObject])
        self.allRecomm.addObjectsFromArray(rate4 as [AnyObject])
        self.allRecomm.addObjectsFromArray(rate3 as [AnyObject])
        self.allRecomm.addObjectsFromArray(rate2 as [AnyObject])
        self.allRecomm.addObjectsFromArray(rate1 as [AnyObject])
        self.tableView.reloadData()
        self.clearSubarray()
    }
    
    func clearSubarray() {
        rate1.removeAllObjects()
        rate2.removeAllObjects()
        rate3.removeAllObjects()
        rate4.removeAllObjects()
        rate5.removeAllObjects()
        rate6.removeAllObjects()
        rate7.removeAllObjects()
        rate8.removeAllObjects()
        
    }
    
    func insertSubarray(a: ActivityModel) {
        var rate = 0
        let type = a.type!
        switch type {
        case "1": //sports
            rate = Int(a.star!) + User.likeSport
        case "2": //sightseeing
            rate = Int(a.star!) + User.likeSightSeeing
        case "3": //indoor
            rate = Int(a.star!) + User.likeIndoor
        case "4": //food
            rate = Int(a.star!) + User.likeFood
        case "5": //outdoors
            rate = Int(a.star!) + User.likeOutdoor
        default:
            break
            
        }
        switch rate {
        case 1: //sports
            rate1.addObject(a)
        case 2: //sightseeing
            rate2.addObject(a)
        case 3: //indoor
            rate3.addObject(a)
        case 4: //food
            rate4.addObject(a)
        case 5: //outdoors
            rate5.addObject(a)
        case 6: //indoor
            rate6.addObject(a)
        case 7: //food
            rate7.addObject(a)
        case 8: //outdoors
            rate8.addObject(a)
        default:
            break
        }
    }
    
    func updateActivity() {
        //        self.clearSubarray()
        for item in allRecomm {
            insertSubarray( item as! ActivityModel)
        }
        combineArray()
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
        do {
            let url = NSURL(string: a.picture!)
            let data = NSData(contentsOfURL: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check
            cell.rcmdImage!.image = UIImage(data: data!)
            
        } catch {
            cell.rcmdImage!.image = UIImage(contentsOfFile: "noimage")
        }
        cell.star1.hidden = false
        cell.star2.hidden = false
        cell.star3.hidden = false
        switch a.star! {
        case 1:
            cell.star2.hidden = true
            cell.star3.hidden = true
        case 2:
            cell.star3.hidden = true
            
        default:
            break
        }
        return cell
        
    }
    
    //Navigate to activity view page with selected row
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        if(segue.identifier == "prefer")
        {
            let nextViewCotroller:FavouriteViewController = segue.destinationViewController as! FavouriteViewController
        }
        else
        {
            let nextViewController:ActivityViewController = segue.destinationViewController as! ActivityViewController
            
            let index = self.tableView.indexPathForSelectedRow!.row
            let selectedActivity: ActivityModel = self.allRecomm[index] as! ActivityModel
            nextViewController.title = self.allRecomm[index].title
            // get data by index and pass it to second view controller
            nextViewController.thisActivity = selectedActivity
        }
        
    }
    
    
    
    
    
    
}
