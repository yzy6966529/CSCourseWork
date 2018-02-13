//
//  FirstToDoDataModel.swift
//  FirstToDo
//
//  Created by Mitja Hmeljak on 2017-09-25.
//  Copyright (c) 2017 CSCI A290. All rights reserved.
//

import UIKit

// here is the data array:
//   we're adding one item here for testing:
//   this should be removed from a "final" app version
var myData: [Item]  = [Item(pContent:"Sample Reminder",
                            pCategory: "Sample Category",
                            pDate:Date(timeIntervalSinceNow: TimeInterval(0)),
                            pDone:false)]

class FirstToDoDataModel  {
    
    // method to add one entry to the myData array:
    func addEntry(_ content: String,
        category: String,
        date: Date,
        done: Bool) {
            
            // ad the entry to the array, as an appended...
            myData.append(
                // ... new Item()
                Item(pContent: content, pCategory: category, pDate: date, pDone: done)
            )
            // for (var i = 0; i < myData.count; i++ ) {
            //     println("the addEntry is for item \(i) and the data is \(myData[i].theCategory)")
            // }
            
            // println("\(myData.count)")
    }
    
    func getArrayData() -> [Item] {
        return myData
    }

    // ------ useful for debugging:
    func getFirstItemCategory() -> String {
        return myData[0].theCategory
    }

    // ------ useful for debugging:
    func getLastItemCategory() -> String {
        // println("the getLastItemCategory is for item \(myData.count-1), and the data is \(myData[(myData.count)-1].theCategory)")
        return myData[(myData.count)-1].theCategory
    }

}


// class defining one entry in the ToDo list:
class Item {

    var theContent: String
    var theCategory: String
    var theDate: Date
    var theDoneFlag: Bool
    
    init (pContent: String, pCategory: String,
        pDate: Date, pDone: Bool) {
             theContent = pContent
             theCategory = pCategory
             theDate = pDate
             theDoneFlag = pDone
    }

}













