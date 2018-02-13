//
//  ShoppingListTableViewController.swift
//  Shopping List
//
//  Created by zhongyu yang on 10/1/17.
//  Copyright © 2017 A290/A590 Fall 2017 - zy7. All rights reserved.
//

import UIKit

var selectedIndex = 0

class ShoppingListTableViewController: UITableViewController {
    
    var myAppdelegate: AppDelegate?
    var mymodel: ListModel?
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Shopping List"
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        myAppdelegate = UIApplication.shared.delegate as? AppDelegate
        mymodel = myAppdelegate?.listDate
        // #warning Incomplete implementation, return the number of rows
        return mymodel!.item.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! listCell

        // create a reference to share the model
        myAppdelegate = UIApplication.shared.delegate as? AppDelegate
        mymodel = myAppdelegate?.listDate
        
        // Configure the cell...
        cell.itemLabel.text = mymodel?.item[indexPath.row].name
        cell.categoryLabel.text = mymodel?.item[indexPath.row].category
        cell.priceLabel.text = mymodel?.item[indexPath.row].price
        cell.dateLabel.text = String(describing: mymodel!.item[indexPath.row].date)

        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        // An alert event to make sure wheather user want delete the item
        let alert = UIAlertController(title: "WARNING", message: "Do you want to delete the item?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            
            if editingStyle == .delete {
                //remove the item from the dictionary
                self.mymodel?.item.remove(at: indexPath.row)
                countItem = countItem - 1
                self.tableView.reloadData()
            } else if editingStyle == .insert {
                // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
            }    

            
            alert.dismiss(animated: true, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: "Default action"), style: .cancel, handler: { _ in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }
 

    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        performSegue(withIdentifier: "segue", sender: self)
    }

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
