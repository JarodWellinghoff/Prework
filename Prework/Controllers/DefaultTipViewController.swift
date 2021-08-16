//
//  ViewController.swift
//  Prework
//
//  Created by Jarod Wellinghoff on 8/15/21.
//

import UIKit
import AVFoundation

class DefaultTipViewController: UIViewController {
	@IBOutlet weak var plusButton: UIButton!
	@IBOutlet weak var percentageField: PercentageField!
	@IBOutlet weak var minusButton: UIButton!
	
	let defaults = UserDefaults.standard
	let buttonSound: SystemSoundID = 1306
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		percentageField.text = defaults.string(forKey: "tip") ?? "10%"
		percentageField.add()
		percentageField.subtract()
		
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
	
	
	@IBAction func changeTipPercent(_ sender: UIButton) {
		let senderTag = sender.tag
		
		if senderTag == 0 {
			percentageField.subtract()
		} else if senderTag == 1 {
			percentageField.add()
		}
		
		AudioServicesPlaySystemSound(buttonSound)
		
	}
	
	@IBAction func doneButtonPressed(_ sender: Any) {
		defaults.set(percentageField.decimal * 100, forKey: "tip")
		self.dismiss(animated: true, completion: nil)
		
	}

}
