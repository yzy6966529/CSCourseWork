//
//  DataEntryViewController.swift
//  FirstToDo
//
//  Created by Mitja Hmeljak on 2017-09-25.
//  Copyright (c) 2017 CSCI A290. All rights reserved.
//

import UIKit

class DataEntryViewController: UIViewController {

    @IBOutlet weak var myContent: UITextField!
    
    @IBOutlet weak var myCategory: UITextField!
    
    @IBOutlet weak var myDatePicker: UIDatePicker!
    
    @IBAction func addItem(_ sender: AnyObject) {
        // add the data from UI to a new item...
        
        // obtain a reference to the AppDelegate:
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        // from the AppDelegate, obtain a reference to the Model data:
        let myDataReference = appDelegate.myFirstToDoData
        
        myDataReference.addEntry(myContent.text!,
            category: myCategory.text!,
            date:myDatePicker.date,
            done: false)
        
         print("from addItem() the data is: \(myDataReference.getLastItemCategory())")
        
        //         myDataReference.addEntry("sleep now.", category: "Health", date: NSDate(timeIntervalSinceNow: NSTimeInterval(0)), done: false)
        let myContainerController = self.splitViewController
        
        let mySiblingController = myContainerController?.viewControllers
        
        let myDetail = mySiblingController?[1]
        
        
        
        
//        FirstToDoTableViewController().tableView.reloadData()
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view,
        //    typically from a nib.
        
        let appDelegate = UIApplication.shared.delegate
            as! AppDelegate
        
        let myDataReference = appDelegate.myFirstToDoData
        
        //   we're adding one ToDo entry here for testing:
        //     this should be removed from a "final" app version
        myDataReference.addEntry("Sample Reminder 2",
            category: "Sample Category 2",
            date: Date(timeIntervalSinceNow: TimeInterval(0)),
            done: false)
        
        // println("from view controller the data is: \(myDataReference.getFirstItemCategory())")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

