//
//  SegueHandler.swift
//  Prework
//
//  Created by Jarod Wellinghoff on 8/14/21.
//

import Foundation
import UIKit

// Singleton to simplify segue "prepare" operations by making the UIViewController unaware of the code that executes to prepare a segue.
class SegueHandler {
	public static var shared = SegueHandler()
	private var preparation : ( ( UIStoryboardSegue ) -> Void )?
	private var withIdentifier : String?
	private init() {}
	
	func performSegue( from view : UIView, withIdentifier : String, sender: Any?, preparation : ( ( UIStoryboardSegue ) -> Void )? = nil ) {
		performSegue( from : view, withIdentifier : withIdentifier, sender : sender, preparation : preparation )
	}

	func performSegue( from viewController : UIViewController, withIdentifier: String, sender: Any?, preparation : ( ( UIStoryboardSegue ) -> Void )? = nil ) {
		self.preparation = preparation
		self.withIdentifier = withIdentifier
		viewController.performSegue(withIdentifier: withIdentifier, sender: sender)
	}
	
	func prepare( for segue: UIStoryboardSegue, sender: Any? ) {
		// Make sure that the segue is the one that was initiated. It's probably not possible for this to go wrong but this is the best check there is right now.
		if segue.identifier == withIdentifier {
			preparation?( segue )
		} else if withIdentifier != nil {
			print( "SegueHandler trying to prepare a segue that doesn't match the one that was initiated." )
		}
		withIdentifier = nil // Try to keep there from being holdover to broken calls later.
	}
	
	func performSegueToViewController( from view : UIView, withIdentifier : String, sender: Any?, preparation : ( ( UIViewController ) -> Void )? = nil ) {
		let storyboard = UIStoryboard( name: "Main", bundle: nil )
		let vc = storyboard.instantiateViewController( withIdentifier: withIdentifier )
		preparation?( vc )
//		view.parentViewController?.show( vc, sender: self )
	}
}
