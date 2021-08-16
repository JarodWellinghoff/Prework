//
//  AppearanceTableViewCell.swift
//  Prework
//
//  Created by Jarod Wellinghoff on 8/15/21.
//

import UIKit

class AppearanceTableViewCell: UITableViewCell {
	@IBOutlet weak var appearanceLabel: UILabel!
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
	}
	
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
		
	}
	
	func setAppearance(_ appearance: String) {
		appearanceLabel.text = appearance
		
	}
	
}
