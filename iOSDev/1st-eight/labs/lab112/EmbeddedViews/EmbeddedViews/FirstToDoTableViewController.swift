//
//  FirstToDoTableViewController.swift
//  FirstToDo
//
//  Created by Mitja Hmeljak on 2017-09-25.
//  Copyright (c) 2017 CSCI A290. All rights reserved.
//

import UIKit

class FirstToDoTableViewController: UITableViewController {

    // the reference to our AppDelegate:
    var appDelegate: AppDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // obtain a reference to the AppDelegate:
        appDelegate = UIApplication.shared.delegate as? AppDelegate

        // from the AppDelegate, obtain a reference to the Model data:
        let myDataReference = appDelegate?.myFirstToDoData
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.

        // from the AppDelegate, obtain a reference to the Model data:
        let myDataReference = appDelegate?.myFirstToDoData
        
        if let myDataCount:Int? = myDataReference?.getArrayData().count {
            print("from tableView numberOfRowsInSection there are: \(myDataCount) rows")
            return myDataCount!
        } else {
            print("there is NO DATA!!!")
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyFirstToDoCell", for: indexPath) as! FirstToDoTableViewCell
        
        // from the AppDelegate, obtain a reference to the Model data:
        let myDataReference = appDelegate?.myFirstToDoData
        
        // get number of Item elements in the Model data array:
        if let myDataCount:Int? = myDataReference?.getArrayData().count {
            
            // get a reference to the Model data array:
            if let myDataArray = myDataReference?.getArrayData() {

                // get a reference to the specific Item in the Model data array:
                let myDataItem = myDataArray[indexPath.row]
                
                // update labels in the table cell:
                cell.reminderTitleLabel.text = "ToDo: \(myDataItem.theContent)"
                cell.categoryLabel.text = "Category: \(myDataItem.theCategory)"
                
                // obtain a "date formatter" from iOS,
                //   to print out the date to the label's text:
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .short
                dateFormatter.timeStyle = .short
                
                cell.dateLabel.text = dateFormatter.string(from: myDataItem.theDate as Date)
                
                if myDataItem.theDoneFlag {
                    cell.doneLabel.text = "Done"
                } else {
                    cell.doneLabel.text = "Do this!"
                }
                
                
            }
            
        }
        
        

        // Configure the cell...

        return cell
    }

}
