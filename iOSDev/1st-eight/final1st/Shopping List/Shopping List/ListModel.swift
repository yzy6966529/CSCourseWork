//
//  ListModel.swift
//  Shopping List
//
//  Created by zhongyu yang on 10/2/17.
//  Copyright © 2017 A290/A590 Fall 2017 - zy7. All rights reserved.
//

import Foundation

class ListModel {
    
    // instantiate an item dictionary
    var item: [Item] = []
    
    // add item entry: add an item to dictionary
    func addEntry(_ pname: String, pprice: String, pcategory: String, pdate: Date){
        item.append(Item(name: pname, price: pprice, category: pcategory, date: pdate))
    }
    
    // edit item entry: edit an exsit item in the dictionary
    func editEntry(_ pname: String, pprice: String, pcategory: String, pdate: Date){
        item[selectedIndex] = Item(name: pname, price: pprice, category: pcategory, date: pdate)
    }
}

class Item: NSObject, NSCoding{
    
    var name: String
    var price: String
    var category: String
    var date: Date
    
    // initialize the Item
    init(name: String,
         price: String,
         category: String,
         date: Date) {
        self.name = name
        self.price = price
        self.category = category
        self.date = date
       
    }
    
    // use NSCoder to decode
    required init?(coder: NSCoder){
        self.name =  coder.decodeObject(forKey: "name") as! String
        self.price = coder.decodeObject(forKey: "price") as! String
        self.category =  coder.decodeObject(forKey: "category") as! String
        self.date =  coder.decodeObject(forKey: "date") as! Date
        super.init()
    }
    
    
    // use NScoder to encode
    func encode(with Coder: NSCoder) {
        Coder.encode(self.name, forKey: "name")
        Coder.encode(self.price, forKey: "price")
        Coder.encode(self.category, forKey: "category")
        Coder.encode(self.date, forKey: "date")
        
    }
    
}

