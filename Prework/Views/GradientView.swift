//
//  GradientView.swift
//  Prework
//
//  Created by Jarod Wellinghoff on 8/7/21.
//

import UIKit

//@IBDesignable
class GradientView: UIView {
	@IBInspectable var startColor: UIColor? {
		didSet { updateGradient() }
		
	}
	
	@IBInspectable var endColor: UIColor? {
		didSet { updateGradient() }
		
	}
	
	@IBInspectable var angle: CGFloat = 270 {
		didSet { updateGradient() }
		
	}
	
	private var gradient: CAGradientLayer?
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		installGradient()
		
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		installGradient()
	}
	
	private func installGradient() {
		if let gradient = self.gradient {
			gradient.removeFromSuperlayer()
			
		}
		let gradient = createGradient()
		gradient.shouldRasterize = true
		self.layer.insertSublayer(gradient, at: 0)
		self.gradient = gradient
		
	}
	
	private func updateGradient() {
		if let gradient = self.gradient {
			let startColor = self.startColor ?? UIColor.clear
			let endColor = self.endColor ?? UIColor.clear
			gradient.colors = [startColor.cgColor, endColor.cgColor]
			let (start, end) = gradientPointsForAngle(self.angle)
			gradient.startPoint = start
			gradient.endPoint = end
			
		}
		
	}
	
	private func createGradient() -> CAGradientLayer {
		let gradient = CAGradientLayer()
		gradient.frame = self.bounds
		return gradient
		
	}
	
	private func gradientPointsForAngle(_ angle: CGFloat) -> (CGPoint, CGPoint) {
		let end = pointForAngle(angle)
		let start = oppositePoint(end)
		let p0 = transformToGradientSpace(start)
		let p1 = transformToGradientSpace(end)
		return (p0, p1)
		
	}
	
	private func pointForAngle(_ angle: CGFloat) -> CGPoint {
		let radians = angle * .pi / 180.0
		var x = cos(radians)
		var y = sin(radians)
		if (abs(x) > abs(y)) {
			x = x > 0 ? 1 : -1
			y = x * tan(radians)
			
		} else {
			y = y > 0 ? 1 : -1
			x = y / tan(radians)
			
		}
		return CGPoint(x: x, y: y)
		
	}
	
	private func transformToGradientSpace(_ point: CGPoint) -> CGPoint {
		return CGPoint(x: (point.x + 1) * 0.5, y: 1.0 - (point.y + 1) * 0.5)
		
	}
	
	private func oppositePoint(_ point: CGPoint) -> CGPoint {
		return CGPoint(x: -point.x, y: -point.y)
		
	}
	
	override func prepareForInterfaceBuilder() {
		super.prepareForInterfaceBuilder()
		installGradient()
		updateGradient()
		
	}
	
	override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
		super.traitCollectionDidChange(previousTraitCollection)
		
		if #available(iOS 13.0, *),
		   let hasUserInterfaceStyleChanged = previousTraitCollection?.hasDifferentColorAppearance(comparedTo: traitCollection),
		   hasUserInterfaceStyleChanged {
			updateGradient()
			
		}
		
	}
	
}
