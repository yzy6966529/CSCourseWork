// Zhongyu Yang zy7@umail.iu.edu
// "PA103 - TabbedApp"
// "A290/A590 / Fall 2017"
// Sep 18, 2017
//
//  FlashCardsViewController.swift
//  TabbedFlashCards
//
//  Created by zhongyu yang on 9/10/17.
//  Copyright © 2017 A290/A590 Fall 2017 - zy7. All rights reserved.
//

import UIKit

class FlashCardsViewController: UIViewController {
    
    // the reference to our AppDelegate
    var appDelegate : AppDelegate?
    // the reference to data model
    var myFlashCardModel : TabbedApplicationModel?
    
    var lQuestion : String?

    
    @IBOutlet weak var questionLable: UILabel!
    @IBOutlet weak var answerLable: UILabel!
   
    @IBAction func QuestionButton(_ sender: AnyObject){
    
    if((myFlashCardModel?.currentQuestionIndex)! >= 2){
        myFlashCardModel?.currentQuestionIndex = 0
    }

    self.lQuestion = self.myFlashCardModel!.getNextQuestion()
    questionLable.text = lQuestion
    answerLable.text = "make a guess"
    }
    
    @IBAction func AnswerButton(_ sender: AnyObject) {
        answerLable.text = myFlashCardModel?.getAnswer()
        myFlashCardModel?.currentQuestionIndex += 1
    }
    
    
    @IBOutlet weak var QuestionButton: UIButton!
    
    @IBOutlet weak var AnswerButton: UIButton!
    
    override func viewDidAppear(_ animated: Bool) {
        flashCards += 1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        // obtain a reference to AppDelegate
        self.appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        // from AppDelegate , obtain a reference to data model
       self.myFlashCardModel = self.appDelegate?.myTabAppModel
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

