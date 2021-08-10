//
//  ViewController.swift
//  Prework
//
//  Created by Jarod Wellinghoff on 8/2/21.
//

import UIKit
import Darwin

extension Decimal {
	var isWholeCurrency: Bool {
		if isZero { return true }
		if !isNormal { return false }
		let myself = self
		let myself_string = NSDecimalNumber(decimal: myself).stringValue
		if myself_string.contains(".") { return false }
		else { return true }
	}
}

class TipViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
	@IBOutlet weak var currencyField:			CurrencyField!
	@IBOutlet weak var tipAmountLabel: 		UILabel!
	@IBOutlet weak var totalLabel:			UILabel!
	@IBOutlet weak var backgroundGradientView: 	GradientView!
	@IBOutlet weak var tipPercentageSlider:		UISlider!
	@IBOutlet weak var tipPercentageLabel:		UILabel!
	@IBOutlet weak var partySizePickerView: 	UIPickerView!
	@IBOutlet weak var tipPercentageTitle: 		UILabel!
	@IBOutlet weak var tipTitle: 				UILabel!
	@IBOutlet weak var tipNavigationItem: 		UINavigationItem!
	@IBOutlet weak var totalTitle:			UILabel!
	@IBOutlet weak var partySizeLabel: 		UILabel!
	@IBOutlet weak var perPersonLabel: 		UILabel!
	@IBOutlet weak var pricePerPersonLabel: 	UILabel!
	@IBOutlet weak var roundingLabel: 			UILabel!
	
	let defaults = UserDefaults.standard
	var pickerData: [Int]!
	var whole_num_curr: [String]!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		print("TipView will load")
		
		partySizePickerView.delegate = self
		partySizePickerView.dataSource = self
		
		self.backgroundGradientView.startColor = UIColor.darkGray
		self.backgroundGradientView.endColor = UIColor.black
		
		self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
		self.navigationController?.navigationBar.shadowImage = UIImage()
		self.navigationController?.navigationBar.isTranslucent = true
		self.navigationController?.view.backgroundColor = .clear
		
		tipAmountLabel.adjustsFontSizeToFitWidth = true
		totalLabel.adjustsFontSizeToFitWidth = true
		tipPercentageLabel.adjustsFontSizeToFitWidth = true
		
		let min_num = 1
		let min_max = 100
		pickerData = Array(stride(from: min_num, to: min_max + 1, by: 1))
		
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		print("TipView will appear")
		
		tipPercentageTitle.textColor = UIColor.white
		tipTitle.textColor = UIColor.white
		totalTitle.textColor = UIColor.white
		partySizeLabel.textColor = UIColor.white
		perPersonLabel.textColor = UIColor.white
		pricePerPersonLabel.textColor = UIColor.white
		roundingLabel.textColor = UIColor.lightGray
		
		let default_currency = defaults.string(forKey: "currency_locale") ?? "Auto"
		
		// Currency formatter
		let currencyFormatter = NumberFormatter()
		currencyFormatter.usesGroupingSeparator = true
		currencyFormatter.numberStyle = .currency
		if default_currency != "Auto" {
			currencyFormatter.locale = Locale.init(identifier: default_currency)
			currencyField.locale = Locale(identifier: default_currency)
			
		} else {
			currencyFormatter.locale = .current
			currencyField.locale = Locale.current
		}
		
		updateTextStyle(0, 0, 0, 0, 0, 0, default_currency)
		
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
	
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 1
		
	}
	
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return pickerData.count
		
	}
	
	
	func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
		let title_data = String(pickerData[row])
		let my_title = NSAttributedString(string: title_data, attributes: [NSAttributedString.Key.foregroundColor:UIColor.white])
		return my_title
	}
	
	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		calculateTip(pickerView)
		
	}
	
	@IBAction func calculateTip(_ sender: Any) {
		// Get party size
		let party_size = Decimal(partySizePickerView.selectedRow(inComponent: 0) + 1)
		
		// Get bill amount from text field input
		let bill_decimal = currencyField.decimal
		let bill_isWhole = bill_decimal.isWholeCurrency
		
		
		// Get tip percentage from slider
		var tip_percentage = Decimal()
		var temp_tp = Decimal.init(floatLiteral: Double(tipPercentageSlider.value))
		NSDecimalRound(&tip_percentage, &temp_tp, 2, .down)
		
		// Calculate tip and total
		var tip = Decimal()
		var temp_tip = bill_decimal * tip_percentage
		NSDecimalRound(&tip, &temp_tip, 2, .down)
		let total = bill_decimal + tip
		
		var price_per_person: Decimal = 0.0
		var rounding: Decimal = 0.0
		var new_total: Decimal = 0.0
		if party_size > 1 {
			var ppp_temp = (total / party_size)
			
			if bill_isWhole == false {
				NSDecimalRound(&price_per_person, &ppp_temp, 2, .up)
				
			}
			else { NSDecimalRound(&price_per_person, &ppp_temp, 0, .up) }
			
			new_total = price_per_person * party_size
			rounding = new_total - total
			
		}
		
		
		print(bill_decimal, tip_percentage, tip, total, rounding, price_per_person)
		//		print(total * 100)
		
		//		print(decimalModulo(total, party_size))
		
		// Send values to change lables
		updateTextStyle(bill_decimal, tip_percentage, tip, total + rounding, rounding, price_per_person, defaults.string(forKey: "currency_locale") ?? "Auto")
		
	}
	
	
	func updateTextStyle( _ bill: Decimal,_ tip_percentage: Decimal, _ tip: Decimal, _ total: Decimal,_ rounding: Decimal, _ price_per_person: Decimal, _ default_currency: String) {
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
		
		if default_currency != "Auto" { currencyFormatter.locale = Locale.init(identifier: default_currency) }
		else { currencyFormatter.locale = .current }
		
		// Update Tip Amount Label
		tipAmountLabel.text = currencyFormatter.string(for: tip)
		
		if tip == 0.00 { tipAmountLabel.textColor = UIColor.gray }
		else { tipAmountLabel.textColor = UIColor.white }
		
		// Update Total Amount
		totalLabel.text = currencyFormatter.string(for:total)
		
		if total == 0.00 { totalLabel.textColor = UIColor.gray }
		else { totalLabel.textColor = UIColor.white }
		
		// Update Tip Percentage
		tipPercentageLabel.text = String("\(tip_percentage * 100)%")
		
		if tip_percentage == 0 { tipPercentageLabel.textColor = UIColor.gray }
		else { tipPercentageLabel.textColor = UIColor.white }
		
		// Update Price Per Person Label
		pricePerPersonLabel.text = currencyFormatter.string(for: price_per_person)
		roundingLabel.text = "+ \(currencyFormatter.string(for: rounding) ?? "")"
		if price_per_person == 0 {
			pricePerPersonLabel.isHidden = true
			perPersonLabel.isHidden = true
			roundingLabel.isHidden = true
//			perPersonLabel.center.x = pricePerPersonLabel.center.x
		} else {
			pricePerPersonLabel.isHidden = false
			perPersonLabel.isHidden = false
			roundingLabel.isHidden = true
			
			if rounding > 0 {
				roundingLabel.isHidden = false
				
			}
		}
	}
	
}
