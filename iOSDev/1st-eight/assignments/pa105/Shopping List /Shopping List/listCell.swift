//
//  ListCell.swift
//  Shopping List
//  zy7@umail.iu.edu
//  PW105
//  A290/A590/Fall 2017
//  Created by zhongyu yang on 10/2/17.
//  Submission Date: 10.09.2017
//  Copyright © 2017 A290/A590 Fall 2017 - zy7. All rights reserved.
//

import UIKit

class listCell: UITableViewCell {
  
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}