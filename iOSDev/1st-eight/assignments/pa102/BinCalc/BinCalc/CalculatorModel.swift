//
//  CalculatorModel.swift
//  BinCalc
//
//  Created by Yang, Zhongyu on 9/4/17.
//  Copyright © 2017 CSCI A290/A590 Fall 2017. All rights reserved.
//  reference:(I used some idea from https://www.youtube.com/watch?v=5tpQEsJ0iVg)

import Foundation
import UIKit

class CalculatorModel{
    
    var firstOperand:Int!  // number on screen
    var secondOperand:Int!  // previous number
    var operation = 0
    var memoryRead = 0
    
    func CalculatorModel() {
        
    }
    
//  store the number on screen
    func setFirstOperand(numOnScreen: String) {
        firstOperand = binary2dec(num: numOnScreen)
    }
    
//  store the privious number
    func setSecondOperand(previousNum: String) {
        secondOperand = binary2dec(num: previousNum)
    }
    
//    Reference：ChinaSwift
//    link：http://www.jianshu.com/p/34d5e958910a
    func binary2dec(num: String) -> Int {
        var sum = 0
        for c in num.characters {
            sum = sum * 2 + Int("\(c)")!
        }
        return sum
    }
    
        // Display and store the operation
    func setOperation(sender: UIButton) -> String{
        if sender.tag == 4{
            operation = sender.tag
            return "+"
        }else if sender.tag == 5{
            operation = sender.tag
            return "-"
        }else if sender.tag == 6{
            operation = sender.tag
            return "*"
        }else if sender.tag == 7{
            operation = sender.tag
            return "/"
        }
        return ""
    }
    
//  Invert previous input operation
    func invert() -> String {
        if operation == 4{
            operation = 5
            return "-"
        }else if operation == 5{
            operation = 4
            return "+"
        }else if operation == 6{
            operation = 7
            return "/"
        }else if operation == 7{
            operation = 6
            return "*"
        }
        return ""
    }
    
    
//  Do the operation and dispay the result
    func performOperation() -> String{
        if operation == 4{
            return String((secondOperand + firstOperand), radix:2)
        }else if operation == 5{
            return String((secondOperand - firstOperand), radix:2)
        }else if operation == 6{
            return String((secondOperand * firstOperand), radix:2)
        }else if operation == 7{
            return String((secondOperand / firstOperand), radix:2)
        }

        return ""
    }

//  (bonus task)
    func memory(sender: UIButton){
        if sender.tag == 10{
            memoryRead = Int(String((binary2dec(num: String(memoryRead)) + firstOperand), radix:2))!
        }else if sender.tag == 11{
            memoryRead = Int(String((binary2dec(num: String(memoryRead)) - firstOperand), radix:2))!
        }else if sender.tag == 13{
            memoryRead = 0
        }
    }
}
