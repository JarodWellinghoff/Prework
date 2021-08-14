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
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setCurrency(_ currency: Currency) {
	symbolLabel.text = currency.symbol
	identifierLabel.text = "\(currency.identifier) (\(currency.code))"

        // Configure the view for the selected state
    }

}
