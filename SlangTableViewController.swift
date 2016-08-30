//
//  SlangTableViewController.swift
//  OZ
//
//  Created by val on 26/08/2016.
//  Copyright © 2016 Qing. All rights reserved.
//

import UIKit

class SlangTableViewController: UITableViewController, UISearchBarDelegate {
    
    var slangs = [String]()
    var filter = [String]()
    @IBOutlet var searchBar: UISearchBar!
    var searchActive : Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        readFromFile()
        searchBar.delegate = self

    }
    
    func readFromFile() {

        let url = NSBundle.mainBundle().URLForResource("slang", withExtension: "json")
        let data = NSData(contentsOfURL: url!)
        do {
            let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
            let items = json as! NSArray
            for slang in (items as NSArray )
            {
                let word = slang["word"] as? String
                let explain = slang["explain"] as? String
                let add =  (word!) + ":\n  " + explain!
                filter.insert(add, atIndex: filter.count)
                slangs.append(add)
                
            }
        } catch {
            // Handle Error
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
        return self.filter.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("slangCell")! as! SlangTableViewCell
        cell.cellWord.text = filter[indexPath.row]
        return cell
    }
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
    }
    // This method updates filteredData based on the text in the Search Box
    // reference: https://github.com/codepath/ios_guides/wiki/Search-Bar-Guide
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        // When there is no text, filteredData is the same as the original data
        if searchText.isEmpty {
            filter = slangs
        } else {
            // The user has entered text into the search box
            // Use the filter method to iterate over all items in the data array
            // For each item, return true if the item should be included and false if the
            // item should NOT be included
            filter = slangs.filter({(dataItem: String) -> Bool in
                // If dataItem matches the searchText, return true to include it
                if dataItem.rangeOfString(searchText, options: .CaseInsensitiveSearch) != nil {
                    return true
                } else {
                    return false
                }
            })
        }
        tableView.reloadData()
    }
}
