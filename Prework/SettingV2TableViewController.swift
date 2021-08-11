//
//  SettingV2TableViewController.swift
//  Prework
//
//  Created by Jarod Wellinghoff on 8/10/21.
//

import UIKit

class SettingV2TableViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
	@IBOutlet weak var backgroundGradientView: 	GradientView!
	@IBOutlet weak var settingsTableView: 	UITableView!

	@IBOutlet weak var darkmodeTableViewCell: 	UITableViewCell!
	@IBOutlet weak var darkmodeContentView: 	UIView!
	@IBOutlet weak var darkmodeLabel: 			UILabel!
	@IBOutlet weak var darkmodeSwitch: 		UISwitch!
	
	@IBOutlet weak var currencyTableViewCell: 	UITableViewCell!
	@IBOutlet weak var currencyContentView: 	UIView!
	@IBOutlet weak var currencyLabel: 			UILabel!
	@IBOutlet weak var currencyPicker: 		UIPickerView!
	
	@IBOutlet weak var maxTipTableViewCell: 	UITableViewCell!
	@IBOutlet weak var maxTipContentView: 		UIView!
	@IBOutlet weak var maxTipLabel: 			UILabel!
	@IBOutlet weak var maxTipPicker: 			UIPickerView!
	
	@IBOutlet weak var defaultTipTableViewCell: 	UITableViewCell!
	@IBOutlet weak var defaultContentView: 		UIView!
	@IBOutlet weak var defaultTipLabel: 		UILabel!
	@IBOutlet weak var defaultTipPicker: 		UIPickerView!
	
	@IBOutlet weak var maxPartySizeTableViewCell: UITableViewCell!
	@IBOutlet weak var maxPartySizeView: UIView!
	@IBOutlet weak var maxPartySizeLabel: UILabel!
	@IBOutlet weak var maxPartySizePicker: UIPickerView!
	
	@IBOutlet weak var defaultPartySizeTableViewCell: 	UITableViewCell!
	@IBOutlet weak var defaultPartySizeContentView: 		UIView!
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
	    
	    self.currencyPicker.dataSource = self
	    self.defaultTipPicker.dataSource = self
	    self.maxTipPicker.dataSource = self
	    self.defaultPartySizePicker.dataSource = self
	    
	    
	    // Do any additional setup after loading the view.
	    currencyPickerData = ["Auto", "Dollar/Peso ($)", "EUR (€)", "JPY (¥)", "GBP (£)", "CHF (CHF)", "CNY (元 / ¥)", "SEK (kr)", "KRW (₩)", "NOK (kr)", "INR (₹)", "RUB (₽)", "ZAR (R)", "TRY (₺)", "DKK (kr)", "PLN (zł)", "THB (฿)", "IDR (Rp)", "HUF (Ft)", "CZK (Kč)", "ILS (₪)", "PHP (₱)", "AED (د.إ)", "MYR (RM)", "RON (L)"]
	    
	    currencyPickerLocale = ["Auto", "en_US", "eu_EU", "jp_JP", "gb_GB", "ch_CH", "cn_CN", "se_SE", "kr_KR", "no_NO", "in_IN", "ru_RU", "za_ZA", "tr_TR", "dk_DK", "pl_PL", "th_TH", "id_ID", "hu_HU", "cs_CZ", "he_IL", "fil_PH", "ar_AE", "ms_MY", "ro_RO"]
	    
	    maxTipPickerData = 			Array(stride(from: 1, to: 300 + 1, by: 1))
	    maxPartySizePickerData = 	Array(stride(from: 1, to: 100, by: 1))
	    
	    

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		print("SettingsView will appear")
		
		let default_dark_mode = 		defaults.bool(forKey: "dark_mode") ?? true
		let default_currency = 		defaults.string(forKey: "currency_name") ?? "Auto"
		let default_max_tip = 		defaults.integer(forKey: "max_tip") ?? 100
		let default_tip = 			defaults.integer(forKey: "tip") ?? 10
		let default_max_party_size = 	defaults.integer(forKey: "max_party_size") ?? 30
		let default_party_size = 	defaults.integer(forKey: "party_size") ?? 1
		
		defaultTipPickerData = 		Array(stride(from: 1, to: default_max_tip + 1, by: 1))
		defaultPartySizePickerData =	Array(stride(from: 1, to: default_max_party_size + 1, by: 1))
		
		if default_dark_mode {
//			self.backgroundGradientView.startColor = UIColor.darkGray
//			self.backgroundGradientView.endColor = UIColor.black
			
//			darkmodeLabel.textColor = 		UIColor.white
//			currencyLabel.textColor = 		UIColor.white
//			maxTipLabel.textColor = 			UIColor.white
//			defaultTipLabel.textColor = 		UIColor.white
//			maxPartySizeLabel.textColor = 	UIColor.white
//			defaultPartySizeLabel.textColor =	UIColor.white
		}
		
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		print("SettingsView did appear")

	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		print("SettingsView will disappear")

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

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
