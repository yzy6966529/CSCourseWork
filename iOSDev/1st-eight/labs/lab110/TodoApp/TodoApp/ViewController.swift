//
//  ViewController.swift
//  TodoApp
//
//  Created by zhongyu yang on 9/25/17.
//  Copyright © 2017 A290/A590 Fall 2017 - zy7. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var appDelegate: AppDelegate?
    var myDataReference: FirstToDoDataModel?
    
//    @IBOutlet weak var myDatePicker: UIDatePicker!
//    
//    @IBOutlet weak var myContent: UITextField!
//    
//    @IBOutlet weak var myCategory: UITextField!
    
    
    @IBOutlet weak var myDatePicker: UIDatePicker!
    @IBOutlet weak var myContent: UITextField!
    @IBOutlet weak var myCategory: UITextField!
    
    @IBAction func addItem(_ sender: Any) {
        appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        myDataReference = appDelegate?.myFirstToDoData
        
        myDataReference?.addEntry(myContent.text!, category: myCategory.text!, date: myDatePicker.date, done: false)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

