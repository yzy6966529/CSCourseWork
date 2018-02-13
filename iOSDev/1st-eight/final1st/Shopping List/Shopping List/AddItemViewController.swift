//
//  AddItemViewController.swift
//  Shopping List
//
//  Created by zhongyu yang on 10/1/17.
//  Copyright © 2017 A290/A590 Fall 2017 - zy7. All rights reserved.
//

import UIKit

class AddItemViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {

    var myAppdelegate: AppDelegate?
    var myListModel: ListModel?
    
    @IBOutlet weak var itemTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var categoryPicker: UIPickerView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var currentDateLabel: UILabel!
    
    // IBAction of the add button to pass the content of item to the pass entry in the model
    @IBAction func addToList(_ sender: Any) {
        
        myListModel?.addEntry(itemTextField.text!, pprice: priceTextField.text! + " ($)", pcategory: myCategory, pdate: datePicker.date)
        countItem = (myListModel?.item.count)!
        creatAleart(title: "Message", Message: "Add Item Successfully")
        print("button works ok")
    }
    
    // PickerView set up
    let category: [String] = ["vegatable", "meat", "juice", "electric", "others"]
    var myCategory: String = "vegatable"

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
    // PickerView set up end
    
    // UIAleart set up
    func creatAleart(title: String, Message:String){
        let alert = UIAlertController(title: title, message: Message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: { _ in
            self.itemTextField.text = ""
            self.priceTextField.text = ""
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    // hide the key board after touch the out side the keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // shows the current date on the top of the view
        currentDateLabel.text = String(describing: Date())
        
        // create a reference to share the model.
        myAppdelegate = UIApplication.shared.delegate as? AppDelegate
        myListModel = myAppdelegate?.listDate
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // create a reference to share the model.
        myAppdelegate = UIApplication.shared.delegate as? AppDelegate
        myListModel = myAppdelegate?.listDate
        
        self.itemTextField.delegate = self
        self.priceTextField.delegate = self
        
        
        view.backgroundColor = UIColor.gray
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    


}

