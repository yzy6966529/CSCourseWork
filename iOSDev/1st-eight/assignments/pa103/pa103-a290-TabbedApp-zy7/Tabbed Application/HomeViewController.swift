//
//  HomeViewController.swift
//  Tabbed Application
//
//  Created by zhongyu yang on 9/17/17.
//  Copyright © 2017 A290/A590 Fall 2017 - zy7. All rights reserved.
//

import Foundation
import UIKit


class HomeViewController: UIViewController {

    
    @IBOutlet weak var flashCardsLabel: UILabel!
    @IBOutlet weak var editingLabel: UILabel!
    @IBOutlet weak var binCalcLabel: UILabel!
    @IBOutlet weak var touchEventLabel: UILabel!
    @IBOutlet weak var concentratedLabel: UILabel!
   
    override func viewDidAppear(_ animated: Bool) {
        flashCardsLabel.text = "Flash Cards: \(flashCards)"
        editingLabel.text = "Flash Cards Editing: \(editingCards)"
        binCalcLabel.text = "BinCalc: \(binCalc)"
        touchEventLabel.text = "Event and Touch: \(eventAndTouch)"
        concentratedLabel.text = "Concentrated: \(concentrated)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

