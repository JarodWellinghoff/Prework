//
//  percentageField.swift
//  Prework
//
//  Created by Jarod Wellinghoff on 8/11/21.
//

import UIKit
import Foundation

class PercentageField: UITextField {
	let padding = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
	
	var decimal: Decimal {  string.decimal / 100 }
	var maximum: Decimal = 9.99
	private var lastValue: String?
	
	
	override open func textRect(forBounds bounds: CGRect) -> CGRect {
		return bounds.inset(by: padding)
		
	}
	
	override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
		return bounds.inset(by: padding)
		
	}
	
	override open func editingRect(forBounds bounds: CGRect) -> CGRect {
		return bounds.inset(by: padding)
		
	}
	
	override func willMove(toSuperview newSuperview: UIView?) {
		addTarget(self, action: #selector(editingChanged), for: .editingChanged)
		keyboardType = .numberPad
		textAlignment = .center
		clearsOnInsertion = true
		textDragInteraction?.isEnabled = false
		sendActions(for: .editingChanged)
		
	}
	
	override func deleteBackward() {
		text = string.digits.dropLast().string
		sendActions(for: .editingChanged)
		
	}
	
	@objc func editingChanged() {
		guard decimal <= maximum else {
			text = lastValue
			return
			
		}
		text = decimal.percentage
		lastValue = text
		
	}
	
	func subtract() {
		guard decimal > 0 else {
			text = lastValue
			return
			
		}
		text = (decimal - 0.01).percentage
		lastValue = text
		
		
	}
	
	func add() {
		guard decimal < maximum else {
			text = lastValue
			return
			
		}
		text = (decimal + 0.01).percentage
		lastValue = text
		
		
	}
	
}

extension PercentageField {
	var doubleValue: Double { (decimal as NSDecimalNumber).doubleValue }
	
}

private extension Formatter {
	static let percentage: NumberFormatter = .init(numberStyle: .percent)
	
}

extension Decimal {
	var percentage: String { Formatter.percentage.string(for: self) ?? "" }
	
}

