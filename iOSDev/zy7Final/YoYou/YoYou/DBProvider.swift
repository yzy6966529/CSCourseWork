//
//  DBProvider.swift
//  YoYou
//
//  Created by zhongyu yang on 11/14/17.
//  Copyright © 2017 A290/A590 Fall 2017 - zy7. All rights reserved.
//  Reference: chat app is biult based on Firbase Chat App https://www.youtube.com/watch?v=t7m_F27cUHY&list=PLZhNP5qJ2IA0ZamF_MDzvmb3bNMv-mLt5

import Foundation
import FirebaseDatabase
import FirebaseStorage
import FirebaseAuth

protocol FetchData: class {
    func dataReceived(contacts: [Contact])
}

class DBProvider{
    
    private static let _instance = DBProvider()
    
    weak var  delegate: FetchData?
    
    var id: String  = (Auth.auth().currentUser?.uid)!
    
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
    
    var MideaMessageRef: DatabaseReference{
        return dbRef.child(Constants.MEDIA_MESSAGES)
    }
    
    var StorageRef: StorageReference{
        return Storage.storage().reference(forURL: "gs://yoyou-ea3b9.appspot.com")
    }
    
    var imageStorageRef: StorageReference{
        return StorageRef.child(Constants.IMAGE_STORAGE)
    }
    
    var videoStorageRef: StorageReference{
        return StorageRef.child(Constants.VIDEO_STORAGE) 
    }
    
    
    func saveUser(withID: String, email: String, password: String){
            let data: Dictionary<String, Any> = [Constants.EMAIL: email, Constants.PASSWORD : password]
            contactsRef.child(withID).setValue(data)
    }
    
    // get contacts from database
    func getContacts(){
        
        contactsRef.observeSingleEvent(of: DataEventType.value) {
            (snapshot: DataSnapshot) in
            var contacts = [Contact]()
            
            if let myContacts = snapshot.value as? NSDictionary{
                
                for (key, value) in myContacts{
                    
                    if let contactData = value as? NSDictionary{
                        
                        if let email = contactData[Constants.EMAIL] as? String{
                            let id = key as! String
                            let newContact = Contact(id: id, name: email)
                            contacts.append(newContact)
                                
                        }
                    }
                }
            }
            self.delegate?.dataReceived(contacts: contacts)
        }
    }
    

    
}
