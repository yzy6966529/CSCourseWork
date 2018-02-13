//
//  FirstToDoDataModel.swift
//  TodoApp
//
//  Created by zhongyu yang on 9/25/17.
//  Copyright © 2017 A290/A590 Fall 2017 - zy7. All rights reserved.
//

import Foundation

class FirstToDoDataModel{
    
    var myData: [Item] = []
    
    func addEntry(_ content: String, category: String, date: Date, done: Bool){
        
        myData.append(
            Item(pContent: content, pCategory: category, pDate: date, pDone: done)
        )
    }

    
    
}

class Item{
    var theContent: String
    var theCategory: String
    var theDate: Date
    var theDone: Bool
    
    init (pContent: String, pCategory: String, pDate: Date, pDone: Bool){
        theContent = pContent
        theCategory = pCategory
        theDate = pDate
        theDone = pDone
    }
    
    
}
