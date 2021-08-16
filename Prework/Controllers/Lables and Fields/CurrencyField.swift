//
//  CurrencyField.swift
//  Prework
//
//  Created by Jarod Wellinghoff on 8/7/21.
//

import UIKit
import Foundation

class CurrencyField: UITextField {
	var padding = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
	var decimalValue: Decimal = 0
	var decimal: Decimal {
		get { string.decimal / pow(10, Formatter.currency.maximumFractionDigits) }
		set {
		    decimalValue = newValue
		    sendActions(for: .editingChanged)
	    }
	}
	var maximum: Decimal = 999_999_999.99
	private var lastValue: String?
	var locale: Locale = .current {
		didSet {
			Formatter.currency.locale = locale
			sendActions(for: .editingChanged)
			
		}
		
	}
	
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
		Formatter.currency.locale = locale
		addTarget(self, action: #selector(editingChanged), for: .editingChanged)
		keyboardType = .numberPad
		textAlignment = .center
		clearsOnInsertion = true
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
		text = decimal.currency
		lastValue = text
		
	}
	
}

extension CurrencyField {
	var doubleValue: Double { (decimal as NSDecimalNumber).doubleValue }
	
}

extension UITextField {
	var string: String { text ?? "" }
	
}

extension NumberFormatter {
	convenience init(numberStyle: Style) {
		self.init()
		self.numberStyle = numberStyle
		
	}
	
}

private extension Formatter {
	static let currency: NumberFormatter = .init(numberStyle: .currency)
	
}

extension StringProtocol where Self: RangeReplaceableCollection {
	var digits: Self { filter (\.isWholeNumber) }
	
}

extension String {
	var decimal: Decimal { Decimal(string: digits) ?? 0 }
	
}

extension Decimal {
	var currency: String { Formatter.currency.string(for: self) ?? "" }
	
}

extension LosslessStringConvertible {
	var string: String { .init(self) }
	
}

extension UITextField {
	@IBInspectable var splitAccessory: Bool {
		get { return self.splitAccessory }
		set (hasSplit) {
			if hasSplit {
				addSplitButtonOnKeyboard()
				
			}
			
		}
		
	}
	
	func addSplitButtonOnKeyboard() {
		let splitToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
		splitToolbar.barStyle = .default
		
		let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
		let split: UIBarButtonItem = UIBarButtonItem(title: "Split", style: .done, target: self, action: #selector(self.splitButtonAction))
		
		let items = [flexSpace, split]
		splitToolbar.items = items
		splitToolbar.sizeToFit()
		
		self.inputAccessoryView = splitToolbar
		
	}
	
	@objc func splitButtonAction() {
		self.resignFirstResponder()
		
	}
	
}
