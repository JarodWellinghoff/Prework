//
//  PickerTableViewCell.swift
//  Prework
//
//  Created by Jarod Wellinghoff on 8/12/21.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {
	@IBOutlet weak var settingLabel: UILabel!
	@IBOutlet weak var defaultLabel: UILabel!
	
	
	let defaults = UserDefaults.standard
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
	
	func setSetting(_ setting: String) {
		settingLabel.text = setting
		defaultLabel.text = defaults.string(forKey: setting) ?? "void"

	   // Configure the view for the selected state
    }

}
