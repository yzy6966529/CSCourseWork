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
        print("button works great")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if(countItem <= 1){
            NumListLabel.text = ("\(countItem) item")
        }else{
            NumListLabel.text = ("\(countItem) items")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = UIColor.blue
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

