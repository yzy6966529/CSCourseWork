//
//  SecondViewController.swift
//  TabbedFlashCards
//
//  Created by zhongyu yang on 9/10/17.
//  Copyright © 2017 A290/A590 Fall 2017 - zy7. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
  
    // the reference to AppDelegate
    var appDelegate : AppDelegate?
    // the reference to datamodel
    var myFlashCardModel : FlashCardsModel?
    
    @IBOutlet weak var questionTextField: UITextField!
    
    @IBOutlet weak var answerTextField: UITextField!
   
    @IBAction func buttonOkAction(_ sender: Any) {
        
        // set question and answer
        myFlashCardModel?.questions[(myFlashCardModel?.currentEditingIndex)!] = questionTextField.text
        myFlashCardModel?.answers[(myFlashCardModel?.currentEditingIndex)!] = answerTextField.text
        
        myFlashCardModel?.currentEditingIndex += 1
        if((myFlashCardModel?.currentEditingIndex)! >= 2){
        myFlashCardModel?.currentEditingIndex = 0
        }
       
        // get next question and answer
        self.questionTextField.text = myFlashCardModel?.questions[(myFlashCardModel?.currentEditingIndex)!]
        self.answerTextField.text = myFlashCardModel?.answers[(myFlashCardModel?.currentEditingIndex)!]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // obtain a reference to AppDelegate
        self.appDelegate = UIApplication.shared.delegate as? AppDelegate
        // from the AppDelegate, obtain a reference to datamodel
        self.myFlashCardModel = self.appDelegate?.myFlashCardModel
        
        // show first question and answer after loading the view
        self.questionTextField.text = myFlashCardModel?.questions[(myFlashCardModel?.currentEditingIndex)!]
        self.answerTextField.text = myFlashCardModel?.answers[(myFlashCardModel?.currentEditingIndex)!]
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

