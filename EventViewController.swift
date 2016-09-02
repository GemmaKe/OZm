//
//  EventViewController.swift
//  OZ
//
//  Created by Le Minh Tuan on 30/08/2016.
//  Copyright © 2016 Qing. All rights reserved.
//

import UIKit
struct event{
    var name:String?
    var image:String?
    var url:String?
}

class EventViewController: UITableViewController {
    
    let listEvent:[event] = [event(name:"Footy", image:"footyEvent.img", url:"http://www.afl.com.au/match-centre"),
                             event(name:"Cricket", image:"cricketEvent.img", url:"http://www.mcg.org.au/whats-on/events-calendar"),
                             event(name:"festival", image:"festivalEvent.img", url:"https://www.festival.melbourne/2016/whats-on/see-all-events/")]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("eventCell", forIndexPath: indexPath) as! EventViewCell
        cell.imgView!.image = UIImage(named: listEvent[indexPath.row].image!)
        cell.labelView!.text = listEvent[indexPath.row].name
        return cell
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return listEvent.count
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let nextViewController:EventWebController = segue.destinationViewController as! EventWebController
        let index = self.tableView.indexPathForSelectedRow!.row
        nextViewController.chosenEvent = self.listEvent[index]
    }

}
