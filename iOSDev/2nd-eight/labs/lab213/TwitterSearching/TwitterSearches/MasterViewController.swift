// MasterViewController.swift
// Handles user interactions with the master list view
// and interacts with the Model
import UIKit

// UITableViewController is a a superclass that provides functionality for UITableView to display a list of items. By inheriting this class, MasterViewController contains all the functions and properties of it. Some of these functions are overriden to provide specific functionality for this app.
class MasterViewController: UITableViewController,
    ModelDelegate {
    
    // DetailViewController contains UIWebView to display search results
    var detailViewController: DetailViewController? = nil
    
    var model: Model! = nil // manages the app's data
    let twitterSearchURL = "https://mobile.twitter.com/search/?q="
    
    // conform to ModelDelegate protocol; updates view when model changes
    func modelDataChanged() {
        tableView.reloadData() // reload the UITableView
    }
    
    // configure popover for UITableView on iPad
    override func awakeFromNib() {
        super.awakeFromNib()
        if UIDevice.current.userInterfaceIdiom == .pad {
            self.clearsSelectionOnViewWillAppear = false
            self.preferredContentSize =
                CGSize(width: 320.0, height: 600.0)
        }
    }

    // called after the view loads for further UI configuration
    override func viewDidLoad() {
        super.viewDidLoad()

        // set up left and right UIBarButtonItems
        
        // displays the edit button that is part of the UITableViewController class.
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        
        // create an add, "+" button, that when pressed calls the addButtonPressed function defined below.
        let addButton = UIBarButtonItem(barButtonSystemItem: .add,
            target: self, action: #selector(MasterViewController.addButtonPressed(_:)))
        // displays the "+" that is part of the UITableViewController class.
        self.navigationItem.rightBarButtonItem = addButton
        
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).viewControllers[0] as? DetailViewController

//            self.detailViewController =
//                controllers[controllers.count-1].topViewController as?
//            DetailViewController
//            
//            (segue.destinationViewController as! UINavigationController).viewControllers[0] as! MYViewController

        }

        model = Model(delegate: self) // create the Model
        model.synchronize() // tell model to sync its data
    }
    
    // displays a UIAlertController to obtain new search from user
    func addButtonPressed(_ sender: AnyObject) {
        displayAddEditSearchAlert(isNew: true, index: nil)
    }

    // handles long press (tap and hold) for editing or sharing a search in the list.
    func tableViewCellLongPressed(
        _ sender: UILongPressGestureRecognizer) {
        // tests if the method was called when a long press began and the UITableView is currently in editing mode.
        if sender.state == UIGestureRecognizerState.began &&
            !tableView.isEditing {
            let cell = sender.view as! UITableViewCell // get cell
        
            if let indexPath = tableView.indexPath(for: cell) {
                displayLongPressOptions(indexPath.row)
            }
        }
    }
    
    // displays the edit/share options
    // uses the UIAlertController class to create a dialog with options to edit a search, share a search, or cancel.
    func displayLongPressOptions(_ row: Int) {
        // create UIAlertController for user input
        let alertController = UIAlertController(title: "Options",
            message: "Edit or Share your search",
            preferredStyle: UIAlertControllerStyle.alert)

        // create Cancel action
        let cancelAction = UIAlertAction(title: "Cancel",
            style: UIAlertActionStyle.cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        let editAction = UIAlertAction(title: "Edit",
            style: UIAlertActionStyle.default,
            handler: {(action) in
                self.displayAddEditSearchAlert(isNew: false, index: row)})
        alertController.addAction(editAction)

        let shareAction = UIAlertAction(title: "Share",
            style: UIAlertActionStyle.default,
            handler: {(action) in self.shareSearch(row)})
        alertController.addAction(shareAction)
        present(alertController, animated: true,
            completion: nil)
    }
    
    // displays add/edit dialog
    func displayAddEditSearchAlert(isNew: Bool, index: Int?) {
        // create UIAlertController for user input
        let alertController = UIAlertController(
            title: isNew ? "Add Search" : "Edit Search",
            message: isNew ? "" : "Modify your query",
            preferredStyle: UIAlertControllerStyle.alert)
        
        // create UITextFields in which user can enter a new search
        // when user adds a new tag/search, the placeholder textfield text is below, which can then be overriden.
        alertController.addTextField(
            configurationHandler: {(textField) in
                if isNew {
                    textField.placeholder = "Enter Twitter search query"
                } else {
                    textField.text = self.model.queryForTagAtIndex(index!)
                }
            })
        
        alertController.addTextField(
            configurationHandler: {(textField) in
                if isNew {
                    textField.placeholder = "Tag your query"
                } else {
                    textField.text = self.model.tagAtIndex(index!)
                    textField.isEnabled = false
                    textField.textColor = UIColor.lightGray
                }
            })
        
        // create Cancel action
        let cancelAction = UIAlertAction(title: "Cancel",
            style: UIAlertActionStyle.cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        let saveAction = UIAlertAction(title: "Save",
            style: UIAlertActionStyle.default,
            handler: {(action) in
                let query =
                    ((alertController.textFields?[0])! as UITextField).text
                let tag =
                    ((alertController.textFields?[1])! as UITextField).text
                
                // ensure query and tag are not empty
                if !query!.isEmpty && !tag!.isEmpty {
                    self.model.saveQuery(
                        query!, forTag: tag!, syncToCloud: true)
                    
                    if isNew {
                        let indexPath =
                            IndexPath(row: 0, section: 0)
                        self.tableView.insertRows(at: [indexPath],
                            with: .automatic)
                    }
                }
        })
        alertController.addAction(saveAction)
        
        present(alertController, animated: true,
            completion: nil)
    }
    
    // when user long taps on a tag in the list, they will get an option to share.
    func shareSearch(_ index: Int) {
        
        // displayed in email if user selects to email the search.
        let message = "Check out the results of this Twitter search"
        let urlString = twitterSearchURL +
            urlEncodeString(model.queryForTagAtIndex(index)!)
        let itemsToShare = [message, urlString]

        // create UIActivityViewController so user can share search
        let activityViewController = UIActivityViewController(
            activityItems: itemsToShare, applicationActivities: nil)
        present(activityViewController,
            animated: true, completion: nil)
    }

    // called when app is about to seque from
    // MainViewController to DetailViewController
    override func prepare(for segue: UIStoryboardSegue,
        sender: Any?) {
        
            // ensures the segue destination is correct.
        if segue.identifier == "showDetail" {
            // NSIndexPath for the row that the user touched.
            if let indexPath = self.tableView.indexPathForSelectedRow  {
                
                // creates reference to DetailViewController, to be used to configure the detailItem property.
                let controller = (segue.destination as!
                    UINavigationController).topViewController as!
                        DetailViewController
                
                // get query String
                let query =
                    String(model.queryForTagAtIndex(indexPath.row)!)
                
                // create NSURL to perform Twitter Search
                controller.detailItem = URL(string: twitterSearchURL +
                    urlEncodeString(query!))
                
                // sets the DetailViewController's left navigation bar button to be the result of the displayModeButtonItem method. In this case: < Twitter Searches, so it is clear the user can return to the list of searches.
                controller.navigationItem.leftBarButtonItem =
                    self.splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton =
                    true
            }
        }
    }
    
    // returns a URL encoded version of the query String
    // URLS contain special URL characters such as : and /
    func urlEncodeString(_ string: String) -> String {
        
        //the stringByAddingPercentEncodingWithAllowedCharacters method encodes the URL characters in the string.
        return string.addingPercentEncoding(
            withAllowedCharacters: CharacterSet.urlQueryAllowed)!
    }

    // callback that returns total number of sections in UITableView
    override func numberOfSections(
        in tableView: UITableView) -> Int {
        return 1
    }

    // callback that returns number of rows in the UITableView
    override func tableView(_ tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
        return model.count
    }

    // callback that returns a configured cell for the given NSIndexPath
    override func tableView(_ tableView: UITableView,
        cellForRowAt indexPath: IndexPath) ->
        UITableViewCell {
            
        // get cell
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "Cell", for: indexPath) 
            
        // set cell label's text to the tag at the specified index
        cell.textLabel?.text = model.tagAtIndex(indexPath.row)
            
        // set up long press guesture recognizer
        let longPressGestureRecognizer = UILongPressGestureRecognizer(
            target: self, action: #selector(MasterViewController.tableViewCellLongPressed(_:)))
        longPressGestureRecognizer.minimumPressDuration = 0.5
        cell.addGestureRecognizer(longPressGestureRecognizer)
            
        return cell
    }

    // callback that returns whether a cell is editable
    override func tableView(_ tableView: UITableView,
        canEditRowAt indexPath: IndexPath) -> Bool {
        return true // all cells are editable
    }

    // callback that deletes a row from the UITableView
    override func tableView(_ tableView: UITableView,
        commit editingStyle: UITableViewCellEditingStyle,
        forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            model.deleteSearchAtIndex(indexPath.row)

            // remove UITableView row
            tableView.deleteRows(
                at: [indexPath], with: .fade)
        }
    }
    
    // callback that returns whether cells can be moved
    override func tableView(_ tableView: UITableView,
        canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // callback that reorders keys when user moves them in the table
    override func tableView(_ tableView: UITableView,
        moveRowAt sourceIndexPath: IndexPath,
        to destinationIndexPath: IndexPath) {
            // tell model to reorder tags based on UITableView order
            model.moveTagAtIndex(sourceIndexPath.row,
                toDestinationIndex: destinationIndexPath.row)
    }

}

/*************************************************************************
* (C) Copyright   by Deitel & Associates, Inc. All Rights Reserved.   *
*                                                                        *
* DISCLAIMER: The authors and publisher of this book have used their     *
* best efforts in preparing the book. These efforts include the          *
* development, research, and testing of the theories and programs        *
* to determine their effectiveness. The authors and publisher make       *
* no warranty of any kind, expressed or implied, with regard to these    *
* programs or to the documentation contained in these books. The authors *
* and publisher shall not be liable in any event for incidental or       *
* consequential damages in connection with, or arising out of, the       *
* furnishing, performance, or use of these programs.                     *
*                                                                        *
* As a user of the book, Deitel & Associates, Inc. grants you the        *
* nonexclusive right to copy, distribute, display the code, and create   *
* derivative apps based on the code. You must attribute the code to      *
* Deitel & Associates, Inc. and reference the book's web page at         *
* www.deitel.com/books/ios8fp1/. If you have any questions, please email *
* at deitel@deitel.com.                                                  *
*************************************************************************/

