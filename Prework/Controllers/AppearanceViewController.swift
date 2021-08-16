//
//  AppearanceViewController.swift
//  Prework
//
//  Created by Jarod Wellinghoff on 8/15/21.
//

import UIKit

class AppearanceViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
	@IBOutlet weak var appearanceTableView: UITableView!
	
	struct Appearance {
		let name: String
		let asdf: UIUserInterfaceStyle
	}
	
	var appearnceSettings: [String] = []
	let defaults = UserDefaults.standard
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.appearanceTableView.delegate = self
		self.appearanceTableView.dataSource = self
		
		
		appearnceSettings = ["Device Preference", "Dark", "Light"]
		
	}
	
	override func viewWillAppear(_ animated: Bool) {
		let appearance = defaults.string(forKey: "appearance") ?? "Device Preference"
		
		if appearance == "Dark" {
			self.overrideUserInterfaceStyle = .dark
			
		} else if appearance == "Light" {
			self.overrideUserInterfaceStyle = .light
			
		} else if appearance == "Device Preference"{
			self.overrideUserInterfaceStyle = .unspecified
			
		}
		
	}
	
	@IBAction func doneButtonPressed(_ sender: Any) {
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
		return appearnceSettings.count
		
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(
				withIdentifier: "appearance",
				for: indexPath) as? AppearanceTableViewCell
		else {
			print("This type of cell is not defined")
			return UITableViewCell()
			
		}
		
		let selectedAppearance = defaults.string(forKey: "appearance") ?? "Device Preference"
		
		if selectedAppearance == appearnceSettings[indexPath.row] {
			cell.accessoryType = .checkmark
			
		} else {
			cell.accessoryType = .none
			
		}
		
		cell.setAppearance(appearnceSettings[indexPath.row])
		
		return cell
		
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let cell = tableView.cellForRow(at: indexPath)
		cell?.accessoryType = .checkmark
		
		let selectedAppearance = appearnceSettings[indexPath.row]
		
		defaults.setValue(selectedAppearance, forKey: "appearance")
		
		self.dismiss(animated: true, completion: nil)
		
	}
	
}
