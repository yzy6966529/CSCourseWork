//
//  SigninVC.swift
//  YoYou
//
//  Created by zhongyu yang on 11/8/17.
//  Copyright © 2017 A290/A590 Fall 2017 - zy7. All rights reserved.
//  Reference: chat app is biult based on Firbase Chat App https://www.youtube.com/watch?v=t7m_F27cUHY&list=PLZhNP5qJ2IA0ZamF_MDzvmb3bNMv-mLt5

import UIKit
import FirebaseAuth
import FirebaseCore

class SigninVC: UIViewController {
    
    private let CONTACT_SEGUE = "ContactsSegue"
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    override func viewDidAppear(_ animated: Bool) {
        if AuthProvider.Instance.isLoggedIn(){
            performSegue(withIdentifier: CONTACT_SEGUE, sender: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // log in button pressed
    @IBAction func loginButton(_ sender: Any) {
        
        // if email text field and password text field is not empty
        if emailTF.text != "" && passwordTF.text != "" {
            AuthProvider.Instance.login(Email: emailTF.text!, password: passwordTF.text!, loginHandler: { (message) in
                
                if message != nil{
                    self.alertUser(title: "Problem Occured With Authentication", message: message!)
                }else{
                    self.emailTF.text = ""
                    self.passwordTF.text = ""
                    
                    self.performSegue(withIdentifier: self.CONTACT_SEGUE, sender: nil)
                }
            })
        }else{
            self.alertUser(title: "Username or Password is Missing", message: "Please Enter your username and password")
        }
    }

    @IBAction func signUpButton(_ sender: Any) {
        
        // if email text field and password text field is not empty
        if emailTF.text != "" && passwordTF.text != "" {
            AuthProvider.Instance.signUp(Email: emailTF.text!, password: passwordTF.text!, loginHandler: { (message) in
                
                if message != nil{
                    self.alertUser(title: "Problem Occured With Creating A New User", message: message!)
                } else {
                    NSLog("Creating user succuessfully and log in")
                    self.emailTF.text = ""
                    self.passwordTF.text = ""
                    
                    self.performSegue(withIdentifier: self.CONTACT_SEGUE, sender: nil)
                }
            })
        }else{
            self.alertUser(title: "Username or Password is Missing", message: "Please Enter your username and password")
        }

    }
    
    // set up an alert
    
    private func alertUser(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
        
    }

}
