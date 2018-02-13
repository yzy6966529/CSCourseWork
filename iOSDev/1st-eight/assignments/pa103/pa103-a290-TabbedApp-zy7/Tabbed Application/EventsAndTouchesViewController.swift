// Zhongyu Yang zy7@umail.iu.edu
// "PA103 - TabbedApp"
// "A290/A590 / Fall 2017"
// Sep 18, 2017
//
//  EventsAndTouchesViewController.swift
//  EventsAndTouches
//
//  Created by Yang, Zhongyu on 9/6/17.
//  Copyright © 2017 A290iOSzy7. All rights reserved.
//

import UIKit

class EventsAndTouchesViewController: UIViewController {
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var tapsLabel: UILabel!
    
    @IBOutlet weak var touchesLabel: UILabel!
    
    
    func updateLabelsFromTouches(_ touches: NSSet){
        let theTouchObject = touches.anyObject() as! UITouch
        let theNumOfTaps = theTouchObject.tapCount
        let theTapsMessage = "\(theNumOfTaps) taps detected in sequence"
        self.tapsLabel.text = theTapsMessage
        let theNumOfTouches = touches.count
        let theTouchesMessage = "\(theNumOfTouches) touches detected at once"
        self.touchesLabel.text = theTouchesMessage
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.messageLabel.text = "Touches Began"
        updateLabelsFromTouches(event!.allTouches! as NSSet)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?){
        self.messageLabel.text = "Touches Moved"
        updateLabelsFromTouches(event!.allTouches! as NSSet)
        if let firstTouch = touches.first {
            let gestureStartPoint = firstTouch.location(in: self.view)
            self.messageLabel.text = "Touches Began at \(gestureStartPoint.x), \(gestureStartPoint.y)"
            updateLabelsFromTouches(event!.allTouches! as NSSet)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?){
        self.messageLabel.text = "Touches Ended"
        updateLabelsFromTouches(event!.allTouches! as NSSet)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?){
        self.messageLabel.text = "Touches Cancelled"
        updateLabelsFromTouches(event!.allTouches! as NSSet)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        eventAndTouch += 1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        self.view.backgroundColor = UIColor.red
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

