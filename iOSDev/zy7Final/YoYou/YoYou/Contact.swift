//
//  Contact.swift
//  YoYou
//
//  Created by zhongyu yang on 11/22/17.
//  Copyright © 2017 A290/A590 Fall 2017 - zy7. All rights reserved.
//  Reference: chat app is biult based on Firbase Chat App https://www.youtube.com/watch?v=t7m_F27cUHY&list=PLZhNP5qJ2IA0ZamF_MDzvmb3bNMv-mLt5

import Foundation

class Contact {
    
    private var _name = ""
    private var _id = ""
    
    init(id: String, name: String){
        _id = id
        _name = name
    }
    
    var name: String {
        return _name
    }
    
    var id: String {
        return _id
    }
}
