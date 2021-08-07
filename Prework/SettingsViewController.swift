//
//  SettingsViewController.swift
//  Prework
//
//  Created by Jarod Wellinghoff on 8/7/21.
//

import UIKit

@IBDesignable
class SettingsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
	@IBOutlet weak var currencyPickerTextField: UITextField!
	@IBOutlet weak var currencyPickerView: UIPickerView!
	
	var currencyPickerData: [String] = [String]()
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		currencyPickerView.isHidden = true
	
		// Set defaults
		let defaults = UserDefaults.standard
		defaults.set("ru_RU", forKey: "currency") // Currency
		
		
		currencyPickerTextField.text = defaults.string(forKey: "currency")
		
		self.currencyPickerTextField.delegate = self
		self.currencyPickerView.delegate = self
		self.currencyPickerView.dataSource = self
		
		currencyPickerData = ["Auto",
						  "Dollar/Peso ($)", 	// en_US
						  "EUR (€)",			// en_EU
						  "JPY (¥)",			// en_JP
						  "GBP (£)",			// en_GB
						  "CHF (CHF)",			// en_CH
						  "CNY (元 / ¥)",		// en_CN
						  "SEK (kr)",			// en_SE
						  "KRW (₩)",			// en_KR
						  "NOK (kr)",			// en_NO
						  "INR (₹)",			// en_IN
						  "RUB (₽)",			// ru_RU
						  "ZAR (R)",
						  "TRY (₺)",
						  "DKK (kr)",
						  "PLN (zł)",
						  "THB (฿)",
						  "IDR (Rp)",
						  "HUF (Ft)",
						  "CZK (Kč)",
						  "ILS (₪)",
						  "CLP (CLP$)",
						  "PHP (₱)",
						  "AED (د.إ)",
						  "COP (COL$)",
						  "SAR (﷼)",
						  "MYR (RM)",
						  "RON (L)"]
		
	}
	
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 1
		
	}
	
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return currencyPickerData.count
		
	}
	

	
//	let defaults = UserDefaults.standard
//
//	// Set default currency
//	defaults.set("en_US", forKey: "currency")
	

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
