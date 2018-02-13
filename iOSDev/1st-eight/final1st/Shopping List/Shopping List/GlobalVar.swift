//
//  GlobalVar.swift
//  Shopping List
//
//  Created by zhongyu yang on 10/2/17.
//  Copyright © 2017 A290/A590 Fall 2017 - zy7. All rights reserved.
//

import UIKit
import Foundation

// Constants var

var myAppdelegate = UIApplication.shared.delegate as? AppDelegate
var myListModel = myAppdelegate?.listDate

var countItem = myListModel!.item.count

let myUsername = "username_preference"
