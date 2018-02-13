//
//  FlashCardsController.swift
//  FlashCardsWithModel
//
//  Created by Yang, Zhongyu on 8/28/17.
//  Copyright © 2017 A290 Fall 2017 - zy7. All rights reserved.
//

import UIKit

class FlashCardsController: UIViewController {

    var myModel : FlashCardsModel = FlashCardsModel()
    
    @IBAction func QuestionButton(_ sender: Any) {
        //Call the getNextQuestion function from the data model instantiated above. 
        myModel.currentQuestionIndex += 1
        if(myModel.currentQuestionIndex >= 2) {myModel.currentQuestionIndex = 0}
        QuestionLable.text = myModel.questions[myModel.currentQuestionIndex]!
        AnswerLabel.text = "make a guess!"
    }

    @IBAction func AnswerButton(_ sender: Any) {
        //make the answer index copy to question index in FlashCardsModel answers var.
        AnswerLabel.text =
            myModel.answers[myModel.currentQuestionIndex]!
    }
    
    @IBOutlet weak var QuestionLable: UILabel!


    @IBOutlet weak var AnswerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // need to instantiate new FlashCardsModel class here.
    
    

}
