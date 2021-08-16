//
//  CurrencyTableViewCell.swift
//  Prework
//
//  Created by Jarod Wellinghoff on 8/12/21.
//

import UIKit

class CurrencyTableViewCell: UITableViewCell {
	@IBOutlet weak var symbolLabel: UILabel!
	@IBOutlet weak var identifierLabel: UILabel!
	
	let defaults = UserDefaults.standard
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
	}
	
	func setCurrency(_ currency: Currency) {
		symbolLabel.text = currency.symbol
		
		var identText = "\(currency.identifier)"
		if Locale.current.currencyCode! == currency.code { identText += " (Auto)" }
		
		identifierLabel.text = identText
		
	}
	
}
