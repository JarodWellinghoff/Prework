//
//  CurrencyViewController.swift
//  Prework
//
//  Created by Jarod Wellinghoff on 8/15/21.
//

import UIKit

class CurrencyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
	@IBOutlet weak var currencyTableView: UITableView!
	
	private lazy var currencies: [Currency] = {
		guard
			let fileURL = Bundle.main.url(forResource: "currency", withExtension: "json"),
			let data = try? Data(contentsOf: fileURL)
		else {
			print("Failed to read currency file")
			return []
			
		}
		
		return (try? JSONDecoder().decode([Currency].self, from: data)) ?? []
		
	} ()
	
	let defaults = UserDefaults.standard
	var sortedCurrencies: [Currency] = []
	
	override func viewDidLoad() {
		super.viewDidLoad()
		let appearance = defaults.string(forKey: "appearance") ?? "Device Preference"
		
		if appearance == "Dark" {
			self.overrideUserInterfaceStyle = .dark
		} else if appearance == "Light" {
			self.overrideUserInterfaceStyle = .light
		} else if appearance == "Device Preference"{
			self.overrideUserInterfaceStyle = .unspecified
		}
		
		self.currencyTableView.delegate = self
		self.currencyTableView.dataSource = self
		
		sortedCurrencies = currencies.sorted { $0.identifier.lowercased() < $1.identifier.lowercased() }
		
		if let autoIndex = sortedCurrencies.firstIndex(where: { $0.code == Locale.current.currencyCode} ) {
			let autoCurrency = sortedCurrencies.remove(at: autoIndex)
			sortedCurrencies.insert(autoCurrency, at: 0)
		}
		
		let previousSelection = defaults.string(forKey: "previousSelection") ?? "0"
		print(Int(previousSelection) ?? 0)
		if Int(previousSelection) ?? 0 > 0 {
			let indexPath = IndexPath(row: Int(previousSelection) ?? 0, section: 0)
			currencyTableView.scrollToRow(at: indexPath, at: .middle, animated: false)
		}
	}
	
	override func viewDidAppear(_ animated: Bool) {
	}
	
	
	
	@IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
		self.dismiss(animated: true, completion: nil)
		
	}
	// MARK: - Table view data source
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 75
		
	}
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.sortedCurrencies.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(
				withIdentifier: "currency",
				for: indexPath) as? CurrencyTableViewCell
		else {
			print("This type of cell is not defined")
			return UITableViewCell()
			
		}
		
		let selectedCurrency = defaults.string(forKey: "defaultIdentifer")
		
		if selectedCurrency! == sortedCurrencies[indexPath.row].identifier {
			cell.accessoryType = .checkmark
		} else {
			cell.accessoryType = .none
		}
		
		cell.setCurrency(sortedCurrencies[indexPath.row])
		
		return cell
	}
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let cell = tableView.cellForRow(at: indexPath)
		cell?.accessoryType = .checkmark
		
		let selectedCurrency = sortedCurrencies[indexPath.row]
		
		defaults.set(indexPath.row, forKey: "previousSelection")
		print(indexPath.row)
		defaults.setValue(selectedCurrency.identifier, forKey: "defaultIdentifer")
		defaults.setValue(selectedCurrency.localID, forKey: "defaultLocalID")
		defaults.setValue(selectedCurrency.code, forKey: "defaultCode")
		defaults.setValue(selectedCurrency.symbol, forKey: "defaultSymbol")
		defaults.setValue(selectedCurrency.isWhole, forKey: "defaultIsWhole")
		
		self.dismiss(animated: true, completion: nil)
		
	}
	func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
		let cell = tableView.cellForRow(at: indexPath)
		cell?.accessoryType = .none
		
	}
	
}
