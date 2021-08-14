//
//  TipV2ViewController.swift
//  Prework
//
//  Created by Jarod Wellinghoff on 8/11/21.
//

import UIKit

class TipV2ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
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
	
	override func viewDidLoad() {
		super.viewDidLoad()
		print("TipView did load...")
		
		self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
		self.navigationController!.navigationBar.shadowImage = UIImage()
		self.navigationController!.navigationBar.isTranslucent = true
		
		self.splitTheBillTableView.delegate = self
		self.splitTheBillTableView.dataSource = self

		
	}
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		print("TipView will appear...")
		currencyField.becomeFirstResponder()
		
		tipCurrencyLabel.locale = currencyField.locale
		totalCurrencyLabel.locale = currencyField.locale
		
		partySize = Array(stride(from: 2, to: 20 + 1, by: 1))
		
	}
	
	@IBAction func calculateTip(_ sender: Any) {
		let tipPercent = percentageField.decimal
		let bill = currencyField.decimal
		
		let tip = tipPercent * bill
		
		let total = bill + tip
		
		if tip > 0 {
			tipLabel.isHidden = true
		} else {
			tipLabel.isHidden = false
		}
		
		if total > 0 {
			totalLabel.isHidden = true
			splitTheBillTableView.isHidden = false
		} else {
			totalLabel.isHidden = false
			splitTheBillTableView.isHidden = true
		}
		
		tipCurrencyLabel.decimal = tip
		totalCurrencyLabel.decimal = total
		
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
