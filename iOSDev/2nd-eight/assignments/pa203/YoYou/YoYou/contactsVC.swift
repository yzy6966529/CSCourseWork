//
//  contactsVC.swift
//  YoYou
//
//  Created by zhongyu yang on 11/8/17.
//  Copyright © 2017 A290/A590 Fall 2017 - zy7. All rights reserved.
//  Reference: chat app is built based on Firbase Chat App https://www.youtube.com/watch?v=t7m_F27cUHY&list=PLZhNP5qJ2IA0ZamF_MDzvmb3bNMv-mLt5



import UIKit

class contactsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
     
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logOutButton(_ sender: Any) {
        if AuthProvider.Instance.logOut() {
            dismiss(animated: true, completion: nil)
        } 
    }

}
