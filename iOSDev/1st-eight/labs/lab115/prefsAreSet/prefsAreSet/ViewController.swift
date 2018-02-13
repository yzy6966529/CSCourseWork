//
//  ViewController.swift
//  prefsAreSet
//
//  Created by zhongyu yang on 10/9/17.
//  Copyright © 2017 A290/A590 Fall 2017 - zy7. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var enable: UILabel!
    @IBOutlet weak var slider: UILabel!
    
    func refreshField(){
        let myDefaults = UserDefaults.standard
        username.text = myDefaults.string(forKey: myUsernameKey)
        name.text = myDefaults.string(forKey: myName)
        enable.text = String(myDefaults.bool(forKey: myEnable))
        slider.text = myDefaults.string(forKey: mySlider)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshField()
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

