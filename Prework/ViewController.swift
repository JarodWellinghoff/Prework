//
//  ViewController.swift
//  Prework
//
//  Created by Jarod Wellinghoff on 8/2/21.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var billAmountTextField: UITextField!
	@IBOutlet weak var tipAmountLabel: UILabel!
	@IBOutlet weak var tipControl: UISegmentedControl!
	@IBOutlet weak var totalLabel: UILabel!
	@IBOutlet weak var backgroundGradientView: UIView!
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Create a gradient layer.
		let topColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1).cgColor
		let bottomColor = #colorLiteral(red: 0, green: 0.5725490196, blue: 0.2705882353, alpha: 1).cgColor
		let gradientLayer = CAGradientLayer()
		// Set the size of the layer to be equal to size of the display.
		gradientLayer.frame = view.bounds
		// Set an array of Core Graphics colors (.cgColor) to create the gradient.
		// This example uses a Color Literal and a UIColor from RGB values.
		gradientLayer.colors = [topColor, bottomColor]
		// Rasterize this static layer to improve app performance.
		gradientLayer.shouldRasterize = true
		// Apply the gradient to the backgroundGradientView.
		backgroundGradientView.layer.addSublayer(gradientLayer)
	}
	
	@IBAction func calculateTip(_ sender: Any) {
		// Get bill amount from text field input
		let bill = Double(billAmountTextField.text!) ?? 0
		
		// Get Total tip by multiplying tip * tipPercentage
		let tipPercentages = [0.15, 0.18, 0.2]
		let tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
		let total = bill + tip
		
		// Update Tip Amount Label
		tipAmountLabel.text = String(format: "$%.2f", tip)
		// Update Total Amount
		totalLabel.text = String(format: "$%.2f", total)
	}
	

}

