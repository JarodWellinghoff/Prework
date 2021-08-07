//
//  ViewController.swift
//  Prework
//
//  Created by Jarod Wellinghoff on 8/2/21.
//

import UIKit
import Darwin

class ViewController: UIViewController {

	@IBOutlet weak var currencyField:			CurrencyField!
	@IBOutlet weak var tipAmountLabel: 		UILabel!
	@IBOutlet weak var totalLabel:			UILabel!
	@IBOutlet weak var backgroundGradientView:	UIView!
	@IBOutlet weak var tipPercentageSlider:		UISlider!
	@IBOutlet weak var tipPercentageLabel:		UILabel!
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
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
	}
	
	override func viewDidAppear(_ animated: Bool) {
		currencyField.becomeFirstResponder()
		
	}
	
	
	@IBAction func textFieldDidBeginEditing(_ textView: CurrencyField) {
		if textView.decimal == 0 {
			print("Empty")
		}

	}
	
	@IBAction func calculateTip(_ sender: Any) {
		// Set currency sign
//		let currency = "$"

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
		
		// Update Tip Amount Label
		let currencyFormatter = NumberFormatter()
		currencyFormatter.locale = Locale.current
		currencyFormatter.usesGroupingSeparator = true
		currencyFormatter.numberStyle = .currency
		
		tipAmountLabel.text = currencyFormatter.string(from: NSDecimalNumber(decimal: tip))
		
		// Update Total Amount
		totalLabel.text = currencyFormatter.string(from: NSDecimalNumber(decimal: total))

		// Update Tip Percentage
		tipPercentageLabel.text = String("\(tipPercentage)%")
		
		
	}
	
	
}

