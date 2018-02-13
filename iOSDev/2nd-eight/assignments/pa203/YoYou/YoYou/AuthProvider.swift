//
//  AuthProvider.swift
//  YoYou
//
//  Created by zhongyu yang on 11/14/17.
//  Copyright © 2017 A290/A590 Fall 2017 - zy7. All rights reserved.
//  Reference: chat app is built based on Firebsae Chat App https://www.youtube.com/watch?v=t7m_F27cUHY&list=PLZhNP5qJ2IA0ZamF_MDzvmb3bNMv-mLt5


import Foundation
import FirebaseAuth

// a closure variable
typealias LoginHandler = (_ msg : String?) -> Void

// will display to the user when login error events happen
struct LoginErrorCode {
    
    static let WRONG_PASSWORD = "Wrong Password, Please Enter The Correct Password"
    static let INVALID_EMAIL = "Invalid Email Address, Please Provide A Real Email Adress"
    static let USER_NOT_FOUND = "User Not Found, Please Sign Up Firstly"
    static let Email_Already_In_Use = "Email Already In Use, Please Use Another Email To Sign Up"
    static let WEAK_PASSWORD = "Password Is Weak, Password Should Be At least 6 Characters Long"
    static let PROBLEM_CONNECTING = "A Problem Occured, Can Not Connect To The Server, Try Later"
}
class AuthProvider {
    
    // create a instance of AuthProvider(), Other class can drictly use this instance.
    private static let _instance = AuthProvider()
    static var Instance: AuthProvider {
        return _instance
    }
    
    // login func
    func login(Email: String, password: String, loginHandler: LoginHandler?){
        Auth.auth().signIn(withEmail: Email, password: password, completion: {
            (user, error) in
            
            if error != nil{
                NSLog("There is an error occured when login")
                self.handleErrors(error: error! as NSError, loginHandler: loginHandler)
            }else{
                NSLog("There is no error occured when log in")
                loginHandler?(nil)
            }
        })
    }
    
    // signUp func
    func signUp(Email: String, password: String, loginHandler: LoginHandler?){
        Auth.auth().createUser(withEmail: Email, password: password, completion: {
            (user, error) in
            
            if error != nil{
                NSLog("There is an error occured when signUp")
                self.handleErrors(error: error! as NSError, loginHandler: loginHandler)
            }else{
                NSLog("There is no error occured when log in")
                if user?.uid != nil{
                   
                    // store the user to database
                    DBProvider.Instance.saveUser(withID: user!.uid, email: Email, password: password)
                    
                    // log in the user
                    self.login(Email: Email, password: password, loginHandler: loginHandler)
                }
            }
        })
    }
    
    // log out
    func logOut()->Bool{
        if Auth.auth().currentUser != nil {
            do {
                try Auth.auth().signOut()
                NSLog("Sign out successfullyy")
                return true
            } catch  {
                // should never happen in this case
                return false
            }
        }
        return true
    }
    
    
    // handle errors
    private func handleErrors(error: NSError, loginHandler: LoginHandler?){
        if let errCode = AuthErrorCode(rawValue: error.code){
            switch errCode {
            
            case .wrongPassword:
                loginHandler?(LoginErrorCode.WRONG_PASSWORD)
                break
            
            case .invalidEmail:
                loginHandler?(LoginErrorCode.INVALID_EMAIL)
                break
                
            case .userNotFound:
                loginHandler?(LoginErrorCode.USER_NOT_FOUND)
                break
                
            case .emailAlreadyInUse:
                loginHandler?(LoginErrorCode.Email_Already_In_Use)
                break
                
            case .weakPassword:
                loginHandler?(LoginErrorCode.WEAK_PASSWORD)
                break
            
            default:
                loginHandler?(LoginErrorCode.PROBLEM_CONNECTING)
                break
            }
        }
    }
}

























