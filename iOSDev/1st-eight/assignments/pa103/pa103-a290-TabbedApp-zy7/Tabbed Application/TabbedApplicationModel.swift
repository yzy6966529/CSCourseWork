// Zhongyu Yang zy7@umail.iu.edu
// "PA103 - TabbedApp"
// "A290/A590 / Fall 2017"
// Sep 18, 2017
//
//  TabbedApplicationModel.swift
//  Tabbed Application
//
//  Created by zhongyu yang on 9/17/17.
//  Copyright © 2017 A290/A590 Fall 2017 - zy7. All rights reserved.
//

import Foundation
import UIKit

class TabbedApplicationModel{
    var currentQuestionIndex = 0 // the question index work in firstViewController
    var currentEditingIndex = 0 // the question index work in secondViewController
    
    var questions =
        [0: "How are you?",
         1: "How much is 1+1 (according to FZ) ?"]
    
    var answers =
        [0: "very well, thank you",
         1: "1 + 1 is 11, says Frank Zappa"]
    
    func getNextQuestion() -> String {
        let lQuestions = questions[currentQuestionIndex]!
        return lQuestions
    }
    
    func getAnswer() -> String {
        return answers[currentQuestionIndex]!
    }
    
    var firstOperand:Int!  // number on screen
    var secondOperand:Int!  // previous number
    var operation = 0
    var memoryRead = "0"
    
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
            memoryRead = String(binary2dec(num: memoryRead) + firstOperand, radix:2)
        }else if sender.tag == 11{
            memoryRead = String(binary2dec(num: memoryRead) - firstOperand, radix:2)
        }else if sender.tag == 13{
            memoryRead = "0"
        }
    }

}
