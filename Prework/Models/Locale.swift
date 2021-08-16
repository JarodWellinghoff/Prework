//
//  locale.swift
//  Prework
//
//  Created by Jarod Wellinghoff on 8/13/21.
//

import Foundation

extension Locale {
	func getAvailableLocales() {
		let locales: NSArray = NSLocale.availableLocaleIdentifiers as NSArray
		var identity: [String] = []
		print("[")
		for localeID in locales as! [NSString] {
			let locale = NSLocale(localeIdentifier: localeID as String)
			let code = locale.object(forKey: NSLocale.Key.currencyCode) as? String
			if code != nil {
				let symbol = locale.object(forKey: NSLocale.Key.currencySymbol) as? String
				let ident = NSLocale(localeIdentifier: "en_US").localizedString(forCurrencyCode: code! as String)
				let group = locale.object(forKey: NSLocale.Key.decimalSeparator) as? String
				if !identity.contains(ident!) {
					identity.append(ident!)
					let formatter = NumberFormatter()
					formatter.locale = Locale(identifier: localeID as String)
					formatter.numberStyle = .currency
					let form = formatter.string(from: 10)!
					var whole: Bool
					if form.contains(group!) {
						whole = false
						
					} else {
						whole = true
						
					}
					print("\t{")
					print("\t\t\"identifier\" : \"\(ident!)\",")
					print("\t\t\"localID\" : \"\(localeID)\",")
					print("\t\t\"code\" : \"\(code!)\",")
					print("\t\t\"symbol\" : \"\(symbol!)\",")
					print("\t\t\"isWhole\" : \(whole)")
					print("\t},")
					
				}
				
			}
			
		}
		print("]")
		
	}
	
}
