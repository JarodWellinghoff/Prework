//
//  SettingsV2TableViewController.swift
//  Prework
//
//  Created by Jarod Wellinghoff on 8/12/21.
//

import UIKit

class SettingsV2TableViewController: UITableViewController {
	var settings: [String] = ["Dark Mode", "Currency", "Default Tip%"]
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Uncomment the following line to preserve selection between presentations
		// self.clearsSelectionOnViewWillAppear = false
		
		// Uncomment the following line to display an Edit button in the navigation bar for this view controller.
		// self.navigationItem.rightBarButtonItem = self.editButtonItem
	}
	
	// MARK: - Table view data source
	
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 100
	}
	
	override func numberOfSections(in tableView: UITableView) -> Int {
		// #warning Incomplete implementation, return the number of sections
		return 1
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		// #warning Incomplete implementation, return the number of rows
		return settings.count
	}
	
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if indexPath.row == 0 {
			guard let cell = tableView.dequeueReusableCell(
					withIdentifier: "switch",
					for: indexPath) as? SwitchTableViewCell
			else {
				
				print("This type of cell is not defined")
				return UITableViewCell()
			}
			
			cell.setSetting(settings[indexPath.row])
			return cell
		} else if indexPath.row == 1 {
			guard let cell = tableView.dequeueReusableCell(
					withIdentifier: "picker",
					for: indexPath) as? CurrencyPickerTableViewCell
			else {
				print("This type of cell is not defined")
				return UITableViewCell()
			}
			
			cell.setSetting(settings[indexPath.row])
			return cell
		} else {
			guard let cell = tableView.dequeueReusableCell(
					withIdentifier: "picker",
					for: indexPath) as? CurrencyPickerTableViewCell
			else {
				print("This type of cell is not defined")
				return UITableViewCell()
			}
			
			cell.setSetting(settings[indexPath.row])
			return cell
		}
	}
	
	
	@IBSegueAction func showCurrencies(_ coder: NSCoder, sender: Any?) -> CurrencyTableViewController? {
		guard
			let cell = sender as? CurrencyPickerTableViewCell,
			let indexPath = tableView.indexPath(for: cell)
		else {
			return nil
		}
		
		tableView.deselectRow(at: indexPath, animated: true)
		
		return CurrencyTableViewController(coder: coder)
	}
	
}
