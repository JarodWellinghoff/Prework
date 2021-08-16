//
//  TipV2ViewController.swift
//  Prework
//
//  Created by Jarod Wellinghoff on 8/11/21.
//

import UIKit
import AVFoundation

class TipViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIInputViewAudioFeedback {
	@IBOutlet weak var currencyField: CurrencyField!
	@IBOutlet weak var backgroundView: GradientView!
	@IBOutlet weak var percentageField: PercentageField!
	@IBOutlet weak var plusButton: UIButton!
	@IBOutlet weak var minusButton: UIButton!
	@IBOutlet weak var tipCurrencyLabel: CurrencyLabel!
	@IBOutlet weak var totalCurrencyLabel: CurrencyLabel!
	@IBOutlet weak var splitTheBillTableView: UITableView!
	@IBOutlet weak var tipLabel: UILabel!
	@IBOutlet weak var totalLabel: UILabel!
	
	var partySize: [Int] = []
	let defaults = UserDefaults.standard
	let buttonSound: SystemSoundID = 1306
	
	override func viewDidLoad() {
		super.viewDidLoad()
		print("TipView did load...")
		
		self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
		self.navigationController!.navigationBar.shadowImage = UIImage()
		self.navigationController!.navigationBar.isTranslucent = true
		
		self.splitTheBillTableView.delegate = self
		self.splitTheBillTableView.dataSource = self
		UserDefaults.resetStandardUserDefaults()
		
		percentageField.text = defaults.string(forKey: "tip") ?? "10%"
		percentageField.add()
		percentageField.subtract()
		

	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		print("TipView will appear...")
		
		currencyField.becomeFirstResponder()
		
		if let defaultLocalID = defaults.string(forKey: "defaultLocalID") {
			currencyField.locale = Locale(identifier: defaultLocalID)
		} else {
			currencyField.locale = NSLocale.current
			defaults.setValue(Locale.current.identifier, forKey: "defaultLocalID")
		}
		
		tipCurrencyLabel.locale = currencyField.locale
		totalCurrencyLabel.locale = currencyField.locale
		
		let appearance = defaults.string(forKey: "appearance") ?? "Device Preference"
		
		if appearance == "Dark" {
			self.overrideUserInterfaceStyle = .dark
		} else if appearance == "Light" {
			self.overrideUserInterfaceStyle = .light
		} else if appearance == "Device Preference"{
			self.overrideUserInterfaceStyle = .unspecified
		}
		
	}
	
	@IBAction func calculateTip(_ sender: Any) {
		let tipPercent = percentageField.decimal
		let bill = currencyField.decimal
		
		let tip = tipPercent * bill
		
		var total = bill + tip
		var maxPartySize: Decimal = 0
		var roundedTotal: Decimal = 0
		
		let isWhole = defaults.string(forKey: "defaultIsWhole") ?? "true"
		
		if isWhole == "true" {
			NSDecimalRound(&roundedTotal, &total, 0, .up)
			
		} else {
			NSDecimalRound(&roundedTotal, &total, 2, .up)
			roundedTotal *= 100
			
		}
		
		if roundedTotal >= 50 { maxPartySize = 50 }
		else { maxPartySize = roundedTotal }
		
		tipCurrencyLabel.decimal = tip
		totalCurrencyLabel.decimal = total
		if maxPartySize > 1 {
			partySize = Array(stride(from: 2, to: (maxPartySize as NSDecimalNumber).intValue + 1, by: 1))
			currencyField.splitAccessory = true
			percentageField.splitAccessory = true
		} else {
			
				
		}
		splitTheBillTableView.reloadData()
	}
	
	@IBAction func changeTipPercent(_ sender: UIButton) {
		let senderTag = sender.tag
		
		if senderTag == 0 {
			percentageField.subtract()
			calculateTip(percentageField!)
		} else if senderTag == 1 {
			percentageField.add()
			calculateTip(percentageField!)
			
		}
		AudioServicesPlaySystemSound(buttonSound)
		
	}
	
	@IBAction func editingDidEnd(_ sender: UITextField) {
		if sender.tag == 0 {
			currencyField.layer.borderWidth = 0.0
			currencyField.borderStyle = .none
			
		} else if sender.tag == 1 {
			percentageField.layer.borderWidth = 0.0
			percentageField.layer.borderColor = UIColor.systemBlue.cgColor
			
		}
		if currencyField.decimal > 0 {
			splitTheBillTableView.isHidden = false
		}
	}
	
	
	@IBAction func editingDidBegin(_ sender: UITextField) {

		if sender.tag == 0 {
			currencyField.layer.borderWidth = 2.0
			currencyField.layer.borderColor = UIColor.systemBlue.cgColor
			
		} else if sender.tag == 1 {
			percentageField.layer.borderWidth = 2.0
			percentageField.layer.borderColor = UIColor.systemBlue.cgColor
			
		}
		
		splitTheBillTableView.isHidden = true
	}
	
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		partySize.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(
				withIdentifier: "PartySizeCell",
				for: indexPath) as? SplitTheBillTableViewCell
		else {
			print("This type of cell is not defined")
			return UITableViewCell()
			
		}
		
		cell.setPartySize(indexPath.row + 2, totalCurrencyLabel.decimal)
		
		return cell
		
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 100
	}
	
}
