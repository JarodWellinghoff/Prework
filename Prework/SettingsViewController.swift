//
//  SettingsViewController.swift
//  Prework
//
//  Created by Jarod Wellinghoff on 8/7/21.
//

import UIKit

//@IBDesignable
class SettingsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
	@IBOutlet weak var currencyPickerTextField: UITextField!
	@IBOutlet weak var currencyPickerView: UIPickerView!
	@IBOutlet weak var pickerToolbar: UIToolbar!
	@IBOutlet weak var pickerBarButton: UIBarButtonItem!
	
	var currencyPickerData: [String] = [String]()
	var currencyPickerLocale: [String] = [String]()
	let defaults = UserDefaults.standard
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		print("SettingsView will load")
		
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
		
		currencyPickerTextField.text = defaults.string(forKey: "currency_name")
		
		currencyPickerView.isHidden = true
		pickerToolbar.isHidden = true
		
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
		defaults.set(currencyPickerData[currencyPickerView.selectedRow(inComponent: 0)], forKey: "currency_name") // Currency name
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
	
	
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		return currencyPickerData[row]
		
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
