//
//  UserCell.swift
//  SharpeApp
//
//  Created by Thomas Fouan on 18/05/2017.
//  Copyright © 2017 Thomas Fouan. All rights reserved.
//

import UIKit

class UserCell: BaseCell {

	@IBOutlet weak var labelUser: UILabel!
	@IBOutlet weak var labelDetail: UILabel!
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
		
		self.labelUser.lineBreakMode = .byWordWrapping
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
