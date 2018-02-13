//
//  multipleMoldel.swift
//  Multiplication Table
//
//  Created by zhongyu yang on 9/20/17.
//  Copyright © 2017 A290/A590 Fall 2017 - zy7. All rights reserved.
//

import Foundation

class multipleModel {
    
    func getLabel(num: Int, num2: Int) -> String{
        var firstNum = num + 1
        var secNum = num2
        
        return "the result of \(firstNum) * \(secNum + 1)"
    }
    
    func getResult(num: Int, num2: Int) -> String{
        
        return String((num + 1) * (num2 + 1))
    }
}
