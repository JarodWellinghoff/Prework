//
//  SettingsV2TableViewController.swift
//  Prework
//
//  Created by Jarod Wellinghoff on 8/12/21.
//

import UIKit

class SettingsTableViewController: UITableViewController {
	@IBOutlet var settingsTableView: UITableView!
	
	struct tableViewCell {
		var cell: UITableViewCell
		var segue: String
	}
	
	struct settingsData {
		var settingsText: String
		var defaultText: String
	}
	
	var settingsDataArray: [settingsData] = []
	var cells: [tableViewCell] = []
	
	let defaults = UserDefaults.standard
	
	let currenciesSegueIdentifier = "ShowCurrenciesSegue"
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		print("Settings View will Appear...")
		let appearance = defaults.string(forKey: "appearance") ?? "Device Preference"
		
		if appearance == "Dark" {
			self.overrideUserInterfaceStyle = .dark
		} else if appearance == "Light" {
			self.overrideUserInterfaceStyle = .light
		} else if appearance == "Device Preference"{
			self.overrideUserInterfaceStyle = .unspecified
		}
		
		
		settingsDataArray = [
			settingsData(settingsText: "Appearance", defaultText: "\(defaults.string(forKey: "appearance") ?? "Device Preference")"),
			settingsData(settingsText: "Currency", defaultText: "\(defaults.string(forKey: "defaultIdentifer") ?? "\(Locale.current.identifier) (Auto)")"),
			settingsData(settingsText: "Default Tip%", defaultText: "\(defaults.string(forKey: "tip") ?? "10")%")
		]
		settingsTableView.reloadData()
		
		
		
	}
	
	override func viewDidAppear(_ animated: Bool) {
		
		print("Settings View Did Appear...")
	}
	
	
	
	// MARK: - Table view data source
	
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 75
		
	}
	
	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1
		
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return settingsDataArray.count
		
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let row = indexPath.row
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "settingsCell") as? SettingsTableViewCell
		else {
			return UITableViewCell()
		}
		
		cell.settingLabel.text = settingsDataArray[row].settingsText
		cell.defaultLabel.text = settingsDataArray[row].defaultText
		
		return cell
		
	}
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let row = indexPath.row
		
		switch row {
			case 0:
				return performSegue(withIdentifier: "ShowAppearanceSegue", sender: self)
			case 1:
				return performSegue(withIdentifier: "ShowCurrenciesSegue", sender: self)
			case 2:
				return performSegue(withIdentifier: "ShowTipSegue", sender: self)
			default:
				print("No segue linked...")
		}
		
	}
	
}
