//
//  FlashCardsModel.swift
//  FlashCardsWithModel
//
//  Created by Yang, Zhongyu on 8/28/17.
//  Copyright © 2017 A290 Fall 2017 - zy7. All rights reserved.
//

import Foundation

class FlashCardsModel {
    
    var currentQuestionIndex = 0
    var questions =
        [0: "How are you",
         1: "How much is 1+1 (according to FZ) ?"]
    
    var answers =
        [0: "very well, thank you",
         1: "1 + 1 is 11, says Frank Zappa"]
    
    func getNextQuestion() -> String {
        let lQuestions = questions[currentQuestionIndex]!
        currentQuestionIndex += 1
        return lQuestions
    }
    func getAnswer() -> String {
        return answers[currentQuestionIndex]!
    }
}
