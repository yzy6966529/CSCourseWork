//
//  AddItemViewController.swift
//  Shopping List
//
//  Created by zhongyu yang on 10/1/17.
//  Copyright © 2017 A290/A590 Fall 2017 - zy7. All rights reserved.
//

import UIKit

class AddItemViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    var myAppdelegate: AppDelegate?
    var myListModel: ListModel?
    
    @IBOutlet weak var itemTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var categoryPicker: UIPickerView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var currentDateLabel: UILabel!
    
    @IBAction func addToList(_ sender: Any) {
        
        myListModel?.addEntry(itemTextField.text!, pprice: priceTextField.text!, pcategory: myCategory, pdate: datePicker.date)
        countItem = (myListModel?.item.count)!
        print("button works ok")
    }
    
    
    let category: [String] = ["vegatable", "meat", "juice", "electric", "others"]
    var myCategory: String = ""
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return category[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return category.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.myCategory = category[row]
    }
    
    override func viewDidAppear(_ animated: Bool) {
        currentDateLabel.text = String(describing: Date())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        myAppdelegate = UIApplication.shared.delegate as? AppDelegate
        myListModel = myAppdelegate?.listDate
        
        view.backgroundColor = UIColor.gray
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

