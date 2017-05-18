//
//  BaseCell.swift
//  SharpeApp
//
//  Created by Thomas Fouan on 18/05/2017.
//  Copyright © 2017 Thomas Fouan. All rights reserved.
//

import UIKit

class BaseCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
		
		separatorInset = UIEdgeInsets.zero
		preservesSuperviewLayoutMargins = false
		layoutMargins = UIEdgeInsets.zero
		layoutIfNeeded()
		
		// Set the selection style to none.
		selectionStyle = UITableViewCellSelectionStyle.none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
