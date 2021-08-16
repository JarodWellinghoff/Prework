//
//  CurrencyLabel.swift
//  Prework
//
//  Created by Jarod Wellinghoff on 8/7/21.
//

import UIKit

class CurrencyLabel: UILabel {
	var decimalValue: Decimal = 0
	var decimal: Decimal {
		get { return decimalValue }
		set { decimalValue = newValue
			 update()
		}
		
	}
	private var lastValue: String?
	var locale: Locale = .current {
		didSet {
			Formatter.currency.locale = locale
			update()
			
		}
		
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		update()
	}
	
	private func update() {
		Formatter.currency.locale = locale
		textAlignment = .right
		text = "\(decimalValue.currency)"
		
	}
	
}

extension UILabel {
	var string: String { text ?? "" }
	
}

private extension Formatter {
	static let currency: NumberFormatter = .init(numberStyle: .currency)
	
}
