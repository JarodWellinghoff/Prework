//
//  CurrencyTableViewController.swift
//  Prework
//
//  Created by Jarod Wellinghoff on 8/12/21.
//

import UIKit

class CurrencyTableViewController: UITableViewController {
	var sortedCurrencies: [Currency] = []
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
	
	override func viewDidLoad() {
		super.viewDidLoad()
		print("Current did load...")
		
		sortedCurrencies = currencies.sorted { $0.identifier.lowercased() < $1.identifier.lowercased() }
		
		if let autoIndex = sortedCurrencies.firstIndex(where: { $0.code == Locale.current.currencyCode} ) {
			let autoCurrency = sortedCurrencies.remove(at: autoIndex)
			sortedCurrencies.insert(autoCurrency, at: 0)
			
		}
		
	}
	
	// MARK: - Table view data source
	
	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1
		
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return sortedCurrencies.count
		
	}
	
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 100
		
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let cell = self.tableView.cellForRow(at: indexPath)
		cell?.accessoryType = .checkmark
		
		let selectedCurrency = sortedCurrencies[indexPath.row]
		
		defaults.setValue(selectedCurrency.identifier, forKey: "defaultIdentifer")
		defaults.setValue(selectedCurrency.localID, forKey: "defaultLocalID")
		defaults.setValue(selectedCurrency.code, forKey: "defaultCode")
		defaults.setValue(selectedCurrency.symbol, forKey: "defaultSymbol")
		defaults.setValue(selectedCurrency.isWhole, forKey: "defaultIsWhole")
		
		self.dismiss(animated: true, completion: nil)
		
	}
	
	override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
		let cell = self.tableView.cellForRow(at: indexPath)
		cell?.accessoryType = .none
		
	}
	
}
