//
//  DetailsViewController.swift
//  ToDoBeWookie
//
//  Created by jason on 5/10/15.
//  Copyright (c) 2015 Jason Hoang. All rights reserved.
//

import UIKit
import CoreData

class DetailsViewController: UIViewController {

    @IBOutlet weak var itemTitle: UILabel!
    @IBOutlet weak var itemDescription: UITextView!
    @IBOutlet weak var datePicker: UIDatePicker!

    var selectedItem = ""

    override func viewDidLoad() {
        itemTitle.text! = selectedItem
    }

}
