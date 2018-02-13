// Zhongyu Yang zy7@umail.iu.edu
// "PA103 - TabbedApp"
// "A290/A590 / Fall 2017"
// Sep 18, 2017
//
//  BinCalcViewController.swift
//  BinCalc
//
//  Created by Yang, Zhongyu on 9/4/17.
//  Copyright © 2017 CSCI A290/A590 Fall 2017. All rights reserved.
//  reference: I used some idea from https://www.youtube.com/watch?v=5tpQEsJ0iVg)

import UIKit

class BinCalcViewController: UIViewController {

    var appDelegate : AppDelegate?
    // instantiate a CalculatorModel object
    var myModel: TabbedApplicationModel?
    
    var numberIsBeingEntered  = false

    @IBOutlet weak var display: UILabel!
    
    func ViewController(){
        
    }
    
    // currently entered number
    @IBAction func aDigitIsPressed(_ sender: UIButton) {
        if numberIsBeingEntered == true{
            display.text = String(sender.tag-1)
            myModel?.setFirstOperand(numOnScreen: display.text!)
            numberIsBeingEntered = false
        }else{
            display.text = display.text! + String(sender.tag-1)
            myModel?.setFirstOperand(numOnScreen: display.text!)
        }
    }
    
    // do the operation or clear or invert operation 
    @IBAction func anOperationIsPressed(_ sender: UIButton) {
        
        // + - * /
        if display.text != "" && (sender.tag == 4 || sender.tag == 5 || sender.tag == 6 || sender.tag == 7){
            myModel?.setSecondOperand(previousNum: display.text!)
            display.text = myModel?.setOperation(sender: sender)
            numberIsBeingEntered = true
        
        // =
        }else if sender.tag == 3{
            display.text = myModel?.performOperation()
        
        // AC
        }else if sender.tag == 9{
            display.text = ""
            myModel?.firstOperand = 0
            myModel?.secondOperand = 0
            myModel?.operation = 0
        }
        
        // invert current operation +/-
        if sender.tag == 8 {
            display.text = myModel?.invert()
        }
        
        // M+ add current(on screen) num to memory
        // M- subtrace current number to memory
        // MR read current memory number
        // MC rest memory number
        if sender.tag == 10 || sender.tag == 11 || sender.tag == 13{
            myModel?.memory(sender: sender)
        }else if sender.tag == 12{
            display.text = myModel?.memoryRead
            myModel?.firstOperand = myModel?.binary2dec(num: (myModel?.memoryRead)!)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        binCalc += 1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // obtain a reference to AppDelegate
        self.appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        // from AppDelegate , obtain a reference to data model
        self.myModel = self.appDelegate?.myTabAppModel

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

