//
//  MessagesHandler.swift
//  YoYou
//
//  Created by zhongyu yang on 11/26/17.
//  Copyright © 2017 A290/A590 Fall 2017 - zy7. All rights reserved.
//  Reference: chat app is biult based on Firbase Chat App https://www.youtube.com/watch?v=t7m_F27cUHY&list=PLZhNP5qJ2IA0ZamF_MDzvmb3bNMv-mLt5

import Foundation
import FirebaseDatabase
import FirebaseStorage

// protocl for message receive
protocol MessageReceivedDelegate: class{
    func messageReceived(senderID: String, text:String)
}

class MessagesHandler{
    private static let _instance = MessagesHandler()
    private init(){}
    
    weak var delegate: MessageReceivedDelegate?
    
    static var Instance: MessagesHandler{
        return _instance
    }
    
    // send message
    func sendMessage(senderID: String, senderName: String, text: String){
        
        let data: Dictionary<String,Any> = [Constants.SENDER_ID: senderID, Constants.SENDER_NAME: senderName, Constants.TEXT: text]
        
        DBProvider.Instance.messageRef.childByAutoId().setValue(data)
    }
    
    // observe message which is in the database
    func observeMessage(){
        DBProvider.Instance.messageRef.observe(DataEventType.childAdded){
            (snapshot: DataSnapshot) in
            
            if let data = snapshot.value as? NSDictionary {
                if let senderID = data[Constants.SENDER_ID] as? String{
                    if let text = data[Constants.TEXT] as? String{
                        self.delegate?.messageReceived(senderID: senderID, text: text)
                    }
                }
            }
        }
    }
    
    
}// Class
