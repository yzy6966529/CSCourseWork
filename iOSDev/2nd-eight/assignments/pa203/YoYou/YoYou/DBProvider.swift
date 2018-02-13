//
//  DBProvider.swift
//  YoYou
//
//  Created by zhongyu yang on 11/14/17.
//  Copyright © 2017 A290/A590 Fall 2017 - zy7. All rights reserved.
//  Reference: chat app is built based on Firbase Chat App https://www.youtube.com/watch?v=t7m_F27cUHY&list=PLZhNP5qJ2IA0ZamF_MDzvmb3bNMv-mLt5

import Foundation
import FirebaseDatabase

class DBProvider{
    
    private static let _instance = DBProvider()
    
    private init(){}
    
    static var Instance: DBProvider{
        return _instance
    }
    
    var dbRef: DatabaseReference{
        return Database.database().reference()
    }
    
    var contactsRef: DatabaseReference{
        return dbRef.child(Constants.CONTACTS)
    }
    
    var messageRef: DatabaseReference{
        return dbRef.child(Constants.MESSAGES)
    }
    
    func saveUser(withID: String, email: String, password: String){
            let data: Dictionary<String, Any> = [Constants.EMAIL: email, Constants.PASSWORD : password]
            contactsRef.child(withID).setValue(data)
        
    }
    
}
