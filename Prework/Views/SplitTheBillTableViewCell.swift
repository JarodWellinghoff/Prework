//
//  SplitTheBillTableViewCell.swift
//  Prework
//
//  Created by Jarod Wellinghoff on 8/12/21.
//

import UIKit

class SplitTheBillTableViewCell: UITableViewCell {
	@IBOutlet weak var partySizeLabel: UILabel!
	@IBOutlet weak var partySizeCurrencyLabel: CurrencyLabel!
	@IBOutlet weak var partySizeImageView: UIImageView!
	
	let defaults = UserDefaults.standard
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
	}
	
	func setPartySize(_ size: Int, _ total: Decimal) {
		var image: UIImage?
		var partyTotal: Decimal = 0
		var partyTotalTemp = total / Decimal(size)
		let isWhole = defaults.string(forKey: "defaultIsWhole") ?? "true"
		
		if isWhole == "true" {
			NSDecimalRound(&partyTotal, &partyTotalTemp, 0, .up)
			
		} else {
			NSDecimalRound(&partyTotal, &partyTotalTemp, 2, .up)
			
		}
		
		if size == 2 {
			image = UIImage(systemName: "person.2.fill")
			
		} else {
			image = UIImage(systemName: "person.3.fill")
			
		}
		
		partySizeLabel.text = "\(size)"
		partySizeImageView.image = image
		partySizeCurrencyLabel.decimal = partyTotal
		
	}
	
}
