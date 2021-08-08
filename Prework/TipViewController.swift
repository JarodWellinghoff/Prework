//
//  ViewController.swift
//  Prework
//
//  Created by Jarod Wellinghoff on 8/2/21.
//

import UIKit
import Darwin

//@IBDesignable
class TipViewController: UIViewController {
	@IBOutlet weak var currencyField:			CurrencyField!
	@IBOutlet weak var tipAmountLabel: 		UILabel!
	@IBOutlet weak var totalLabel:			UILabel!
//	@IBOutlet weak var backgroundGradientView:	GradientView!
	@IBOutlet weak var backgroundGradientView: 	GradientView!
	@IBOutlet weak var tipPercentageSlider:		UISlider!
	@IBOutlet weak var tipPercentageLabel:		UILabel!
	@IBOutlet weak var partySizePickerView: 	UIPickerView!
	
	let defaults = UserDefaults.standard
	
	override func viewDidLoad() {
		super.viewDidLoad()
		print("TipView will load")
		
		self.title = "Tip Calculator"
		
		
		tipAmountLabel.adjustsFontSizeToFitWidth = true
		totalLabel.adjustsFontSizeToFitWidth = true
		tipPercentageLabel.adjustsFontSizeToFitWidth = true
	
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		print("TipView will appear")
		
		// Reset values when
		updateTextStyle(0, 0, 0, 0)
		
	
	}

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		print("TipView did appear")
	
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
		updateTextStyle(bill_decimal, tip_percentage, tip, total)
		
	}
	
	func updateTextStyle(_ bill: Decimal, _ tip_percentage: Int, _ tip: Decimal, _ total: Decimal) {
		// Get currency symbol
		let default_currency = defaults.string(forKey: "currency_locale") ?? "Auto"
		
		// Currency formatter
		let currencyFormatter = NumberFormatter()
		currencyFormatter.usesGroupingSeparator = true
		currencyFormatter.numberStyle = .currency
		if default_currency != "Auto" {
			currencyFormatter.locale = Locale(identifier: default_currency)
			
		} else {
			currencyFormatter.locale = .current
		}
		
		// Update bill amount text
		if bill == 0 {
			currencyField.textColor = UIColor.gray
			currencyField.text = "Bill Amount"
			currencyField.textAlignment = NSTextAlignment.center
		} else {
			currencyField.textColor = UIColor.black
		}
		
		// Update Tip Amount Label
		tipAmountLabel.text = currencyFormatter.string(from: NSDecimalNumber(decimal: tip))
		if tip == 0.00 {
			tipAmountLabel.textColor = UIColor.gray
		} else {
			tipAmountLabel.textColor = UIColor.black
		}
		
		// Update Total Amount
		totalLabel.text = currencyFormatter.string(from: NSDecimalNumber(decimal: total))
		if total == 0.00 {
			totalLabel.textColor = UIColor.gray
		} else {
			totalLabel.textColor = UIColor.black
		}

		// Update Tip Percentage
		tipPercentageLabel.text = String("\(tip_percentage)%")
		if tip_percentage == 0 {
			tipPercentageLabel.textColor = UIColor.gray
		} else {
			tipPercentageLabel.textColor = UIColor.black
		}
		
	}
	
	func gradientBackground(_ top_color: CGColor, _ bottom_color: CGColor) {
		// Create a gradient layer.
		let gradientLayer = CAGradientLayer()
		// Set the size of the layer to be equal to size of the display.
		gradientLayer.frame = self.view.bounds
		// Set an array of Core Graphics colors (.cgColor) to create the gradient.
		gradientLayer.colors = [top_color, bottom_color]
		// Rasterize this static layer to improve app performance.
		gradientLayer.shouldRasterize = true
		// Apply the gradient to the backgroundGradientView.
		self.view.layer.insertSublayer(gradientLayer, at: 0)
		
		view.sendSubviewToBack(backgroundGradientView)
		
	}
	
}
