//
//  SettingsViewController.swift
//  Prework
//
//  Created by Jarod Wellinghoff on 8/7/21.
//

import UIKit

class SettingsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
	@IBOutlet weak var currencyPickerTextField: 	UITextField!
	@IBOutlet weak var currencyPickerView: 		UIPickerView!
	@IBOutlet weak var pickerToolbar: 			UIToolbar!
	@IBOutlet weak var backgroundGradientView: 	GradientView!
	@IBOutlet weak var pickerBarButton: 		UIBarButtonItem!
	@IBOutlet weak var currencyTitleLabel: 		UILabel!
	
	var currencyPickerData: [String]!
	var currencyPickerLocale: [String]!
	let defaults = UserDefaults.standard
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		print("SettingsView will load")
		
		self.backgroundGradientView.startColor = UIColor.darkGray
		self.backgroundGradientView.endColor = UIColor.black
		
		self.currencyPickerTextField.delegate = self
		self.currencyPickerView.delegate = self
		self.currencyPickerView.dataSource = self
		
		currencyPickerData = ["Auto", "Dollar/Peso ($)", "EUR (€)", "JPY (¥)", "GBP (£)", "CHF (CHF)", "CNY (元 / ¥)", "SEK (kr)", "KRW (₩)", "NOK (kr)", "INR (₹)", "RUB (₽)", "ZAR (R)", "TRY (₺)", "DKK (kr)", "PLN (zł)", "THB (฿)", "IDR (Rp)", "HUF (Ft)", "CZK (Kč)", "ILS (₪)", "PHP (₱)", "AED (د.إ)", "MYR (RM)", "RON (L)"]
		
		currencyPickerLocale = ["Auto", "en_US", "eu_EU", "jp_JP", "gb_GB", "ch_CH", "cn_CN", "se_SE", "kr_KR", "no_NO", "in_IN", "ru_RU", "za_ZA", "tr_TR", "dk_DK", "pl_PL", "th_TH", "id_ID", "hu_HU", "cs_CZ", "he_IL", "fil_PH", "ar_AE", "ms_MY", "ro_RO"]
		
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
		
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		print("SettingsView will appear")
		
		currencyTitleLabel.textColor = UIColor.white
		
		let default_currency = defaults.string(forKey: "currency_name") ?? "Auto"
		
		currencyPickerTextField.text = default_currency
		let sected_row = currencyPickerData.firstIndex(of: default_currency)!
		
		currencyPickerView.isHidden = true
		pickerToolbar.isHidden = true
		
//		self.currencyPickerView.selectRow(currencyPickerView.selectedRow(inComponent: 0), inComponent: 0, animated: true)
		
		currencyPickerView.selectRow(sected_row, inComponent: 0, animated: true)
		currencyPickerView.backgroundColor = UIColor.darkGray
		pickerToolbar.backgroundColor = UIColor.gray
		pickerBarButton.tintColor = UIColor.white
		currencyPickerTextField.backgroundColor = UIColor.lightGray
		
		// This is a good place to retrieve the default tip percentage from UserDefaults
		// and use it to update the tip amount
	
	}

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		print("SettingsView did appear")
	
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		print("SettingsView will disappear")
		
		// Set defaults
		defaults.set(currencyPickerLocale[currencyPickerView.selectedRow(inComponent: 0)], forKey: "currency_locale") // Currency locale
		defaults.set(currencyPickerData[currencyPickerView.selectedRow(inComponent: 0)], forKey: "currency_name") 	// Currency name
//		defaults.set()
		
	}
	
	override func viewDidDisappear(_ animated: Bool) {
		super.viewDidAppear(animated)
		print("SettingsView did disappear")
		
	}
	
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 1
		
	}
	
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return currencyPickerData.count
		
	}
	
	
	func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
		let title_data = currencyPickerData[row]
		let my_title = NSAttributedString(string: title_data, attributes: [NSAttributedString.Key.foregroundColor:UIColor.white])
		return my_title
	}

	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		self.currencyPickerTextField.text = currencyPickerData[row];
		
	}
	
	func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
		self.currencyPickerView.isHidden = false
		self.pickerToolbar.isHidden = false
		return false
		
	}
	func dismissPickerView() {
		self.currencyPickerTextField.inputAccessoryView = pickerToolbar
	}
	
	@IBAction func dismissPicker(_ sender: UIBarButtonItem) {
		self.currencyPickerTextField.isHidden = false
		self.currencyPickerView.isHidden = true
		self.pickerToolbar.isHidden = true
		self.currencyPickerView.resignFirstResponder()
		
	}

}
