//
//  ListViewController.swift
//  ToDoBeWookie
//
//  Created by jason on 5/10/15.
//  Copyright (c) 2015 Jason Hoang. All rights reserved.
//

import UIKit
import CoreData

class ListsViewController: UIViewController, UITableViewDataSource {

    var itemsList = [NSManagedObject]()

    // stubbed for now
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! UITableViewCell
        let items = itemsList[indexPath.row]
        cell.textLabel!.text = items.valueForKey("item") as? String
        return cell
    }
}
