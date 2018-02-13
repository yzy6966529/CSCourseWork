//
//  FirstToDoTableViewCell.swift
//  FirstToDo
//
//  Created by Mitja Hmeljak on 2017-09-25.
//  Copyright (c) 2017 CSCI A290. All rights reserved.
//

import UIKit

class FirstToDoTableViewCell: UITableViewCell {
    
    // outlet connections referring to labels in the UITableView prototype:
    @IBOutlet weak var reminderTitleLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var doneLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
