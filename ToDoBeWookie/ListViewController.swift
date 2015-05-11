//
//  ItemsViewController.swift
//  ToDoBeWookie
//
//  Created by Jason Hoang on 5/2/15.
//  Copyright (c) 2015 Jason Hoang. All rights reserved.
//

import UIKit
import CoreData

class ListViewController: UITableViewController, UITableViewDataSource {
    
    @IBOutlet weak var listTableView: UITableView!

    @IBAction func addItem(sender: AnyObject) {
        // popup view for entering a new list item
        var alert = UIAlertController(title: "New item", message: "Add a new item", preferredStyle: .Alert)
        
        // append textfield contents to itemsList
        let saveAction = UIAlertAction(title: "Save", style: .Default) { (action: UIAlertAction!) -> Void in
            let textField = alert.textFields![0] as! UITextField
            self.saveItem(textField.text)
            self.listTableView.reloadData()
        }
        
        // do nothing and return to primary view
        let cancelAction = UIAlertAction(title: "Cancel", style: .Default) {
            (action: UIAlertAction!) -> Void in
        }
        
        // add textfield for entering the name of the list item
        alert.addTextFieldWithConfigurationHandler {
            (textField: UITextField!) -> Void in
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        presentViewController(alert, animated: true, completion: nil)
    }
    
    func saveItem(item: String) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext  = appDelegate.managedObjectContext!
        let entity = NSEntityDescription.entityForName("List", inManagedObjectContext: managedContext)
        let items = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
       
        items.setValue(item, forKey: "item")
        
        var error: NSError?
        if !managedContext.save(&error) {
            println("Could not save \(error), \(error?.userInfo)")
        }
        
        itemsList.append(items)
    }
    
    var itemsList = [NSManagedObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "The List"
        listTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        let fetchRequest = NSFetchRequest(entityName: "List")
        var error: NSError?
        
        let fetchedResults = managedContext.executeFetchRequest(fetchRequest, error: &error) as? [NSManagedObject]
        
        if let results = fetchedResults {
            itemsList = results
        } else {
            println("Coudl not fetch \(error), \(error!.userInfo)")
        }
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsList.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = listTableView.dequeueReusableCellWithIdentifier("cell") as! UITableViewCell
        let items = itemsList[indexPath.row]
        cell.textLabel!.text = items.valueForKey("item") as? String
        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let controller = storyboard!.instantiateViewControllerWithIdentifier("DetailsViewController") as! DetailsViewController

        controller.selectedItem = (itemsList[indexPath.row].valueForKey("item") as? String)!

        self.navigationController!.pushViewController(controller, animated: true)
    }
}

