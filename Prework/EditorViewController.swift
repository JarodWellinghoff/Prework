//
//  EditorViewController.swift
//  Prework
//
//  Created by Jarod Wellinghoff on 8/7/21.
//

import UIKit

class EditorViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
	override func pressesBegan(_ presses: Set<UIPress>,
							 with event: UIPressesEvent?) {
		   super.pressesBegan(presses, with: event)
		   presses.first?.key.map(keyPressed)
	    }

	    override func pressesEnded(_ presses: Set<UIPress>,
							 with event: UIPressesEvent?) {
		   super.pressesEnded(presses, with: event)
		   presses.first?.key.map(keyReleased)
	    }

	    override func pressesCancelled(_ presses: Set<UIPress>,
								with event: UIPressesEvent?) {
		   super.pressesCancelled(presses, with: event)
		   presses.first?.key.map(keyReleased)
	    }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
