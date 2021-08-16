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
        // Initialization code
    }

	func setPartySize(_ size: Int, _ total: Decimal) {
		partySizeLabel.text = "\(size)"
		var image: UIImage?
		var partyTotal: Decimal = 0
		var partyTotalTemp = total / Decimal(size)
		
		if total.isWholeCurrency {
			NSDecimalRound(&partyTotal, &partyTotalTemp, 0, .up)
		} else {
			NSDecimalRound(&partyTotal, &partyTotalTemp, 2, .up)
			
		}
		
		if size == 2 {
			image = UIImage(systemName: "person.2.fill")
		} else {
			image = UIImage(systemName: "person.3.fill")
		}
		
		partySizeImageView.image = image
		partySizeCurrencyLabel.decimal = partyTotal
		

        // Configure the view for the selected state
    }

}
