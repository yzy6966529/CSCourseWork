//
//  ViewController.swift
//  drawView
//
//  Created by zhongyu yang on 9/13/17.
//  Copyright © 2017 A290/A590 Fall 2017 - zy7. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let subViewFrame = CGRect(x: 30, y:50, width: 100, height: 150)
        let ourSubView = ConcentratedView(frame: subViewFrame)
        ourSubView.backgroundColor = UIColor.red
        if let lView = self.view{
            print("the view defined in main.storyboard is \(lView)")
            lView.addSubview(ourSubView)
        
        }
        
        let anotherViewFrame = CGRect(x: 70, y:100, width: 25, height: 200)
        let ourSubViewTwo = ConcentratedView(frame: anotherViewFrame)
        ourSubViewTwo.backgroundColor = UIColor.yellow
        if let lView = self.view{
            print("the view defined in main.storyboard is \(lView)")
            lView.addSubview(ourSubViewTwo)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

