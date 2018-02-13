//
//  ListModel.swift
//  Shopping List
//
//  Created by zhongyu yang on 10/2/17.
//  Copyright © 2017 A290/A590 Fall 2017 - zy7. All rights reserved.
//

import Foundation

class ListModel {
    var item: [Item] = []
    
    func addEntry(_ pname: String, pprice: String, pcategory: String, pdate: Date){
        item.append(Item(name: pname, price: pprice, category: pcategory, date: pdate))
    }
}

class Item{
    
    var name: String
    var price: String
    var category: String
    var date: Date
    
    init(name: String,
         price: String,
         category: String,
         date: Date) {
        self.name = name
        self.price = price
        self.category = category
        self.date = date
    }
    
}
