//
//  PickerTableViewCell.swift
//  Prework
//
//  Created by Jarod Wellinghoff on 8/12/21.
//

import UIKit

class CurrencyPickerTableViewCell: UITableViewCell {
	@IBOutlet weak var settingLabel: UILabel!
	@IBOutlet weak var defaultLabel: UILabel!
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
	
	func setSetting(_ setting: String) {
		settingLabel.text = setting

	   // Configure the view for the selected state
    }

}
