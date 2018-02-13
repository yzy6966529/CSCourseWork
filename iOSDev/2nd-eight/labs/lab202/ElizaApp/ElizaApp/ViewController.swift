//
//  ViewController.swift
//  ElizaApp
//
//  Created by zhongyu yang on 10/18/17.
//  Copyright © 2017 A290/A590 Fall 2017 - zy7. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    var mydata:Eliza = Eliza()
    
    
    @IBOutlet weak var outputTextView: UITextView!
    @IBOutlet weak var inputTextField: UITextField!
    
    @IBAction func send(_ sender: Any) {
        let userInput = inputTextField.text
        mydata.setInput(userInput: userInput!)
        
       
        
        outputTextView.text = mydata.getOutput()
        inputTextField.text = ""
        print(mydata.output)
        print(mydata.getOutput())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        outputTextView.text = "Elisa: hi"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

