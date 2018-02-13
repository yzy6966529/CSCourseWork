//
//  hw102zy7.swift
//  
//
//  Created by zhongyu yang on 9/4/17.
//
//

import Foundation

// random a number between 1~100
func randomNum() -> Int {
    return Int(arc4random_uniform(100))+1
}

print ("Welcome to the guessing game!, please enter your guessing number between 1-100")

// get a guessing number from user
var inputNum = Int(readLine()!)

// initial counting times
var count:Int = 1
var num = randomNum()

// get out from loop when user's guessing number equal random number
while(inputNum != num){
    if(inputNum! < num){
        print("Please guess higher")
        inputNum = Int(readLine()!)
        count+=1
    }else if(inputNum! > num){
        print("Please guess lower")
        inputNum = Int(readLine()!)
        count+=1
    }
}

print("Congratulations! You are right!")
print("You totally count \(count) times")
