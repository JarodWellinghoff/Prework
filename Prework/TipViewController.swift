//
//  ViewController.swift
//  Prework
//
//  Created by Jarod Wellinghoff on 8/2/21.
//

import UIKit
import Darwin

@IBDesignable
class TipViewController: UIViewController {
	@IBOutlet weak var currencyField:			CurrencyField!
	@IBOutlet weak var tipAmountLabel: 		UILabel!
	@IBOutlet weak var totalLabel:			UILabel!
	@IBOutlet weak var backgroundGradientView:	UIView!
	@IBOutlet weak var tipPercentageSlider:		UISlider!
	@IBOutlet weak var tipPercentageLabel:		UILabel!
	let defaults = UserDefaults.standard
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.title = "Tip Calculator"
		
//		billAmountTextField.becomeFirstResponder()
		// Set top and bottom colors
		let topColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1).cgColor
		let bottomColor = #colorLiteral(red: 0, green: 0.5725490196, blue: 0.2705882353, alpha: 1).cgColor
		// Create a gradient layer.
		let gradientLayer = CAGradientLayer()
		// Set the size of the layer to be equal to size of the display.
		gradientLayer.frame = self.view.bounds
		// Set an array of Core Graphics colors (.cgColor) to create the gradient.
		gradientLayer.colors = [topColor, bottomColor]
		// Rasterize this static layer to improve app performance.
		gradientLayer.shouldRasterize = true
		// Apply the gradient to the backgroundGradientView.
		self.view.layer.insertSublayer(gradientLayer, at: 0)
		view.sendSubviewToBack(backgroundGradientView)
		
		tipAmountLabel.adjustsFontSizeToFitWidth = true
		totalLabel.adjustsFontSizeToFitWidth = true
		tipPercentageLabel.adjustsFontSizeToFitWidth = true
		
		// Get currency symbol
		let default_currency = defaults.string(forKey: "currency") ?? "Auto"
		
		let tip: Decimal = 0
		let total: Decimal = 0
		// Currency formatter
		let currencyFormatter = NumberFormatter()
		currencyFormatter.locale = Locale(identifier: default_currency)
		currencyFormatter.usesGroupingSeparator = true
		currencyFormatter.numberStyle = .currency
		
		// Update Tip Amount Label
		tipAmountLabel.text = currencyFormatter.string(from: NSDecimalNumber(decimal: tip))
		
		// Update Total Amount
		totalLabel.text = currencyFormatter.string(from: NSDecimalNumber(decimal: total))
		
		// Update bill currency
		if default_currency != "Auto" {
			currencyField.locale = Locale.init(identifier: default_currency)
		} else {
			currencyField.locale = .current
		}
	
	}
	

	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		print("TipView will appear")
		
		// Access UserDefaults
		let default_currency = defaults.string(forKey: "currency") ?? "Auto"
		
		// Update bill currency
		if default_currency != "Auto" {
			currencyField.locale = Locale.init(identifier: default_currency)
		} else {
			currencyField.locale = .current
		}
		
		currencyField.becomeFirstResponder()
		if currencyField.decimal == 0 {
			currencyField.text = "Bill Amount"
		}
		
		defaults.string(forKey: "currency")
		// This is a good place to retrieve the default tip percentage from UserDefaults
		// and use it to update the tip amount
	
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

	
	@IBAction func textFieldDidBeginEditing(_ textView: CurrencyField) {
		if textView.decimal == 0 {
			textView.text = "Bill Amount"
			textView.textAlignment = NSTextAlignment.center
		}

	}
	
	@IBAction func calculateTip(_ sender: Any) {
		// Get currency symbol
		let default_currency = defaults.string(forKey: "currency")
		
		// Get bill amount from text field input
		let bill_decimal = currencyField.decimal
		
		// Get tip percentage from slider
		let tipPercentage = Int(tipPercentageSlider.value * 100)

		// Calculate tip and total
		var tip = bill_decimal * (Decimal(tipPercentage) / 100)
		if tipPercentage < 1 {
			tip = 0.00
		}
		let total = bill_decimal + tip
		
		// Currency formatter
		let currencyFormatter = NumberFormatter()
		currencyFormatter.locale = Locale(identifier: default_currency!)
		currencyFormatter.usesGroupingSeparator = true
		currencyFormatter.numberStyle = .currency
		
		// Update Tip Amount Label
		tipAmountLabel.text = currencyFormatter.string(from: NSDecimalNumber(decimal: tip))
		
		// Update Total Amount
		totalLabel.text = currencyFormatter.string(from: NSDecimalNumber(decimal: total))

		// Update Tip Percentage
		tipPercentageLabel.text = String("\(tipPercentage)%")
		
	}
	func getSymbol(forCurrencyCode code: String) -> String? {
	    let locale = NSLocale(localeIdentifier: code)
	    if locale.displayName(forKey: .currencySymbol, value: code) == code {
		   let newlocale = NSLocale(localeIdentifier: code.dropLast() + "_en")
		   return newlocale.displayName(forKey: .currencySymbol, value: code)
	    }
	    return locale.displayName(forKey: .currencySymbol, value: code)
	}
	
	
	@IBAction func change_currency(_ sender: UIButton) {
		defaults.set("fr_FR", forKey: "currency")
	}
}
