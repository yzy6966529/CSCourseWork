//
//  Eliza.swift
//  ElizaApp
//
//  Created by zhongyu yang on 10/18/17.
//  Copyright © 2017 A290/A590 Fall 2017 - zy7. All rights reserved.
//

import Foundation

class Eliza{
    
    let category:[String] = ["joy", "disgust", "fear", "anger", "sadness"]
    let joyWords:[String] = ["happy", "joy", "yeah"]
    let disgustWord:[String] = ["sicken", "nauseate"]
    let fearWord:[String] = ["foreboding", "apprehension"]
    let anger:[String] = ["resentment", "exasperation"]
    let sadness:[String] = ["unhappy", "despondent","sad", "upSet"]
    
    
    
    var userInputA: [String] = []
    var userInput: String = ""
    var output:[String] = ["Elisa: hi"]
    
    func setInput(userInput: String){
        self.userInput = userInput
        output.append("User: " + self.userInput)
        
        let inputLowerCase = userInput.lowercased()
        let inputWithoutNewLine = inputLowerCase.components(separatedBy: "\n")
        let inputWords = inputWithoutNewLine[0].components(separatedBy: " ")
        self.userInputA = inputWords
        output.append("Elisa: " + getResponseFromModel())
    }
    
    func getOutput() -> String{
        var output = ""
        for i in 0 ... self.output.count - 1{
            output = output + self.output[i] + "\n"
        }
        return output
    }
    
    func getResponseFromModel() -> String{
        
        
        for i in 0 ... userInputA.count - 1{
            if joyWords.contains(userInputA[i]){
                return  "It is very nice"
            }else if disgustWord.contains(userInputA[i]){
                return "Leave it away"
            }else if fearWord.contains(userInputA[i]){
                return "Let me give you a hug"
            }else if anger.contains(userInputA[i]){
                return "Take easy bro"
            }else if sadness.contains(userInputA[i]){
                return "Be a man/woman!!"
            }
        }
        
        return "Please say something else"
    }
    
}
