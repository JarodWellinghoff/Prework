//
//  ViewController.swift
//  Prework
//
//  Created by Jarod Wellinghoff on 8/2/21.
//

import UIKit
import Darwin

class TipViewController: UIViewController {
	@IBOutlet weak var currencyField:			CurrencyField!
	@IBOutlet weak var tipAmountLabel: 		UILabel!
	@IBOutlet weak var totalLabel:			UILabel!
	@IBOutlet weak var backgroundGradientView: 	GradientView!
	@IBOutlet weak var tipPercentageSlider:		UISlider!
	@IBOutlet weak var tipPercentageLabel:		UILabel!
	@IBOutlet weak var partySizePickerView: 	UIPickerView!
	@IBOutlet weak var tipPercentageTitle: 		UILabel!
	@IBOutlet weak var tipTitle: 				UILabel!
	@IBOutlet weak var totalTitle:			UILabel!
	
	let defaults = UserDefaults.standard
	
	override func viewDidLoad() {
		super.viewDidLoad()
		print("TipView will load")
		
		self.backgroundGradientView.startColor = UIColor.darkGray
		self.backgroundGradientView.endColor = UIColor.black
		self.navigationController?.navigationBar.isTranslucent = true
		
		
		tipAmountLabel.adjustsFontSizeToFitWidth = true
		totalLabel.adjustsFontSizeToFitWidth = true
		tipPercentageLabel.adjustsFontSizeToFitWidth = true
		

	
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		print("TipView will appear")
		
		tipPercentageTitle.textColor = UIColor.white
		tipTitle.textColor = UIColor.white
		totalTitle.textColor = UIColor.white
		
		let default_currency = defaults.string(forKey: "currency_locale") ?? "Auto"

		// Currency formatter
		let currencyFormatter = NumberFormatter()
		currencyFormatter.usesGroupingSeparator = true
		currencyFormatter.numberStyle = .currency
		if default_currency != "Auto" {
			currencyFormatter.locale = Locale.init(identifier: "eu_EU")
			currencyField.locale = Locale(identifier: default_currency)
			
		} else {
			currencyFormatter.locale = .current
			currencyField.locale = Locale.current
		}
		
		updateTextStyle(0, 0, 0, 0, default_currency)
		
	}

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		print("TipView did appear")
		// Reset values when
		
		currencyField.becomeFirstResponder()
	
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		print("TipView will disappear")
		
	}
	
	override func viewDidDisappear(_ animated: Bool) {
		super.viewDidAppear(animated)
		print("TipView did disappear")
		
	}
	
	@IBAction func calculateTip(_ sender: Any) {
		// Get bill amount from text field input
		let bill_decimal = currencyField.decimal
		
		// Get tip percentage from slider
		let tip_percentage = Int(tipPercentageSlider.value * 100)

		// Calculate tip and total
		var tip = bill_decimal * (Decimal(tip_percentage) / 100)
		if tip < 0.005 {
			tip = 0.00
		}
		let total = bill_decimal + tip
		
		// Send values to change lables
		updateTextStyle(bill_decimal, tip_percentage, tip, total, defaults.string(forKey: "currency_locale") ?? "Auto")
		
	}
	
	func updateTextStyle( _ bill: Decimal,_ tip_percentage: Int, _ tip: Decimal, _ total: Decimal, _ default_currency: String) {
		// Get currency symbol
		let default_currency = defaults.string(forKey: "currency_locale") ?? "Auto"

		// Update bill amount text
		if bill == 0 {
			currencyField.textColor = UIColor.gray
			currencyField.text = "Bill Amount"
			currencyField.textAlignment = NSTextAlignment.center
		} else {
			
			currencyField.textColor = UIColor.white
		}
		
		// Currency formatter
		let currencyFormatter = NumberFormatter()
		currencyFormatter.usesGroupingSeparator = true
		currencyFormatter.numberStyle = .currency
		if default_currency != "Auto" {
			currencyFormatter.locale = Locale.init(identifier: default_currency)
			
		} else {
			currencyFormatter.locale = .current
		}
		
		// Update Tip Amount Label
		tipAmountLabel.text = currencyFormatter.string(from: NSDecimalNumber(decimal: tip))
		if tip == 0.00 {
			tipAmountLabel.textColor = UIColor.gray
		} else {
			tipAmountLabel.textColor = UIColor.white
		}
		
		// Update Total Amount
		totalLabel.text = currencyFormatter.string(from: NSDecimalNumber(decimal: total))
		if total == 0.00 {
			totalLabel.textColor = UIColor.gray
		} else {
			totalLabel.textColor = UIColor.white
		}

		// Update Tip Percentage
		tipPercentageLabel.text = String("\(tip_percentage)%")
		if tip_percentage == 0 {
			tipPercentageLabel.textColor = UIColor.gray
		} else {
			tipPercentageLabel.textColor = UIColor.white
		}
		
	}
	
	func updateCurrency() {
		
	}
	
}
