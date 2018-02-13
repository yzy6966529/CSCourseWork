//
//  HomeViewController.swift
//  Shopping List
//
//  Created by zhongyu yang on 10/1/17.
//  Copyright © 2017 A290/A590 Fall 2017 - zy7. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var NumListLabel: UILabel!
    @IBAction func addNewItem(_ sender: Any) {
        // test button if work or not
        print("button works great")
    }
    @IBOutlet weak var username: UILabel!
    
    // set the user name that using the preference from the setting buddle
    func setting(){
        let myDefault = UserDefaults.standard
        username.text = myDefault.string(forKey: myUsername)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if(countItem <= 1){
            NumListLabel.text = ("\(String(describing: countItem)) item")
        }else{
            NumListLabel.text = ("\(String(describing: countItem)) items")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // call setting when the home scence is loaded
        setting()
        
       
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

