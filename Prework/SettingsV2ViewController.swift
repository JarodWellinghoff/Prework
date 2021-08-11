//
//  SettingsV2ViewController.swift
//  Prework
//
//  Created by Jarod Wellinghoff on 8/10/21.
//

import UIKit
extension UserDefaults {
	static func contains(_ key: String) -> Bool {
		return UserDefaults.standard.object(forKey: key) != nil
	}
}

class SettingsV2ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
	@IBOutlet var backgroundGradientView: GradientView!
	
	@IBOutlet weak var darkmodeLabel: 			UILabel!
	@IBOutlet weak var darkmodeSwitch: 		UISwitch!
	
	@IBOutlet weak var currencyLabel: 			UILabel!
	@IBOutlet weak var currencyPicker: 		UIPickerView!
	
	@IBOutlet weak var maxTipLabel: 			UILabel!
	@IBOutlet weak var maxTipPicker: 			UIPickerView!
	
	@IBOutlet weak var defaultTipLabel: 		UILabel!
	@IBOutlet weak var defaultTipPicker: 		UIPickerView!
	
	@IBOutlet weak var maxPartySizeLabel: UILabel!
	@IBOutlet weak var maxPartySizePicker: UIPickerView!
	
	@IBOutlet weak var defaultPartySizeLabel: 			UILabel!
	@IBOutlet weak var defaultPartySizePicker: 			UIPickerView!
	
	
	var currencyPickerData: [String]!
	var currencyPickerLocale: [String]!
	var maxTipPickerData: [Int]!
	var defaultTipPickerData: [Int]!
	var maxPartySizePickerData: [Int]!
	var defaultPartySizePickerData: [Int]!
	
	let defaults = UserDefaults.standard
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		print("SettingsView did load")
		
		self.currencyPicker.delegate = self
		self.defaultTipPicker.delegate = self
		self.maxTipPicker.delegate = self
		self.defaultPartySizePicker.delegate = self
		self.maxPartySizePicker.delegate = self
		
		self.currencyPicker.dataSource = self
		self.defaultTipPicker.dataSource = self
		self.maxTipPicker.dataSource = self
		self.defaultPartySizePicker.dataSource = self
		self.maxPartySizePicker.dataSource = self
		
		
		// Do any additional setup after loading the view.
		currencyPickerData = ["Auto", "Dollar/Peso ($)", "EUR (€)", "JPY (¥)", "GBP (£)", "CHF (CHF)", "CNY (元 / ¥)", "SEK (kr)", "KRW (₩)", "NOK (kr)", "INR (₹)", "RUB (₽)", "ZAR (R)", "TRY (₺)", "DKK (kr)", "PLN (zł)", "THB (฿)", "IDR (Rp)", "HUF (Ft)", "CZK (Kč)", "ILS (₪)", "PHP (₱)", "AED (د.إ)", "MYR (RM)", "RON (L)"]
		
		currencyPickerLocale = ["Auto", "en_US", "eu_EU", "jp_JP", "gb_GB", "ch_CH", "cn_CN", "se_SE", "kr_KR", "no_NO", "in_IN", "ru_RU", "za_ZA", "tr_TR", "dk_DK", "pl_PL", "th_TH", "id_ID", "hu_HU", "cs_CZ", "he_IL", "fil_PH", "ar_AE", "ms_MY", "ro_RO"]
		
		maxTipPickerData = Array(stride(from: 1, to: 300 + 1, by: 1))
		maxPartySizePickerData = Array(stride(from: 1, to: 100 + 1, by: 1))
		
		
		
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		print("SettingsView will appear")
		
		var default_dark_mode = true
		if UserDefaults.contains("dark_mode") {
			default_dark_mode = defaults.bool(forKey: "dark_mode")
		}
		defaults.setValue(default_dark_mode, forKey: "dark_mode")
		darkmodeSwitch.setOn(default_dark_mode, animated: true)
		
		let default_currency = defaults.string(forKey: "currency_locale") ?? "Auto"
		let sected_row = currencyPickerLocale.firstIndex(of: default_currency)!
		currencyPicker.selectRow(sected_row, inComponent: 0, animated: true)
		
		var default_max_tip = 100
		if UserDefaults.contains("max_tip") {
			default_max_tip = defaults.integer(forKey: "max_tip")
		}
		defaults.set(default_max_tip, forKey: "max_tip")
		defaultTipPickerData = Array(stride(from: 1, to: default_max_tip + 1, by: 1))
		maxTipPicker.selectRow(default_max_tip - 1, inComponent: 0, animated: true)
		
		var default_tip = 10
		if UserDefaults.contains("tip") {
			default_tip = defaults.integer(forKey: "tip")
		}
		defaults.set(default_tip, forKey: "tip")
		defaultTipPicker.selectRow(default_tip - 1, inComponent: 0, animated: true)
		
		var default_max_party_size = 30
		if UserDefaults.contains("max_party_size") {
			default_max_party_size = defaults.integer(forKey: "max_party_size")
		}
		defaults.set(default_max_party_size, forKey: "max_party_size")
		maxPartySizePicker.selectRow(default_max_party_size - 1, inComponent: 0, animated: true)
		
		var default_party_size = 1
		if UserDefaults.contains("party_size") {
			default_party_size = defaults.integer(forKey: "party_size")
		}
		defaults.set(default_party_size, forKey: "party_size")
		defaultPartySizePickerData =	Array(stride(from: 1, to: default_max_party_size + 1, by: 1))
		defaultPartySizePicker.selectRow(default_party_size - 1, inComponent: 0, animated: true)
		
		
		if default_dark_mode {
			self.backgroundGradientView.startColor = UIColor.darkGray
			self.backgroundGradientView.endColor = UIColor.black
			
			darkmodeLabel.textColor = 		UIColor.white
			currencyLabel.textColor = 		UIColor.white
			maxTipLabel.textColor = 			UIColor.white
			defaultTipLabel.textColor = 		UIColor.white
			maxPartySizeLabel.textColor = 	UIColor.white
			defaultPartySizeLabel.textColor =	UIColor.white
			
		} else {
			self.backgroundGradientView.startColor = UIColor.white
			self.backgroundGradientView.endColor = UIColor.green
			
			darkmodeLabel.textColor = 		UIColor.black
			currencyLabel.textColor = 		UIColor.black
			maxTipLabel.textColor = 			UIColor.black
			defaultTipLabel.textColor = 		UIColor.black
			maxPartySizeLabel.textColor = 	UIColor.black
			defaultPartySizeLabel.textColor =	UIColor.black
			
		}
		
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		print("SettingsView did appear")

	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		print("SettingsView will disappear")
		
//		// Set defaults
//		var selected_row = currencyPicker.selectedRow(inComponent: 0)
//		defaults.set(currencyPickerLocale[selected_row], forKey: "currency_locale") // Currency locale
//		defaults.set(currencyPickerData[selected_row], forKey: "currency_name") 	// Currency name
//
//		selected_row = maxTipPicker.selectedRow(inComponent: 0)
//		defaults.set(selected_row + 1, forKey: "max_tip")
//
//		selected_row = defaultTipPicker.selectedRow(inComponent: 0)
//		defaults.set(selected_row + 1, forKey: "tip")
//
//		selected_row = maxPartySizePicker.selectedRow(inComponent: 0)
//		defaults.set(selected_row + 1, forKey: "max_party_size")
//
//		selected_row = defaultPartySizePicker.selectedRow(inComponent: 0)
//		defaults.set(selected_row + 1, forKey: "party_size")
		defaults.setValue(darkmodeSwitch.isOn, forKey: "dark_mode")

	}
	
	override func viewDidDisappear(_ animated: Bool) {
		super.viewDidDisappear(animated)
		print("SettingsView did disappear")

	}
	
	
	
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 1
	}
	
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		switch pickerView.tag {
			case 0:
				return currencyPickerData.count
			case 1:
				return maxTipPickerData.count
			case 2:
				return defaultTipPickerData.count
			case 3:
				return maxPartySizePickerData.count
			case 4:
				return defaultPartySizePickerData.count
			default:
				print("Something weird happened")
				return 0
		}
	}
	
	func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
		var title_data = String()
		switch pickerView.tag {
			case 0:
				title_data = currencyPickerData[row]
			case 1:
				title_data = String(maxTipPickerData[row])
			case 2:
				title_data = String(defaultTipPickerData[row])
			case 3:
				title_data = String(maxPartySizePickerData[row])
			case 4:
				title_data = String(defaultPartySizePickerData[row])
			default:
				print("Something weird happened")
				title_data = "?"
		}
		let my_title = NSAttributedString(string: title_data, attributes: [NSAttributedString.Key.foregroundColor:UIColor.white])
		return my_title
	}
	
	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		// Set defaults
		let selected_row = currencyPicker.selectedRow(inComponent: 0)
		defaults.set(currencyPickerLocale[selected_row], forKey: "currency_locale") // Currency locale
		defaults.set(currencyPickerData[selected_row], forKey: "currency_name") 	// Currency name
		
//		selected_row = maxTipPicker.selectedRow(inComponent: 0)
		defaults.set(maxTipPicker.selectedRow(inComponent: 0) + 1, forKey: "max_tip")
		
//		selected_row = defaultTipPicker.selectedRow(inComponent: 0)
		defaults.set(defaultTipPicker.selectedRow(inComponent: 0) + 1, forKey: "tip")
		
//		selected_row = maxPartySizePicker.selectedRow(inComponent: 0)
		defaults.set(maxPartySizePicker.selectedRow(inComponent: 0) + 1, forKey: "max_party_size")
		
//		selected_row = defaultPartySizePicker.selectedRow(inComponent: 0)
		defaults.set(defaultPartySizePicker.selectedRow(inComponent: 0) + 1, forKey: "party_size")
	}
	
	
}
