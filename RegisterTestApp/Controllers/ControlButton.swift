//
//  ControllButton.swift
//  RegisterTestApp
//
//  Created by Igor Zubko on 01.10.16.
//  Copyright © 2016 Igor Zubko. All rights reserved.
//

import UIKit

private enum ButtonConfig {
	static let normalTextColor = UIColor.white
	static let highlightedTextColor = UIColor.lightText
	static let disabledTextColor = ButtonConfig.normalColor
	
	static let normalColor = UIColor(hex: 0x0AB8B4)
	static let highlightedColor = UIColor(hex: 0x009999)
	static let disabledColor = ButtonConfig.normalColor.withAlphaComponent(0.5)
}

class ControlButton: UIButton {
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		
		self.setTitleColor(ButtonConfig.normalTextColor, for: .normal)
		self.setTitleColor(ButtonConfig.highlightedTextColor, for: .highlighted)
		self.setTitleColor(ButtonConfig.disabledTextColor, for: .disabled)
		
		self.setBackgroundColor(color: ButtonConfig.normalColor, forState: .normal)
		self.setBackgroundColor(color: ButtonConfig.highlightedColor, forState: .highlighted)
		self.setBackgroundColor(color: ButtonConfig.disabledColor, forState: .disabled)
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		
		self.layer.cornerRadius = self.frame.size.height / 2
		self.layer.shadowOffset = CGSize(width: 0, height: 2)
		self.clipsToBounds = true
	}
	
	func setBackgroundColor(color: UIColor, forState: UIControlState) {
		UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
		UIGraphicsGetCurrentContext()!.setFillColor(color.cgColor)
		UIGraphicsGetCurrentContext()!.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
		let colorImage = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		
		self.setBackgroundImage(colorImage, for: forState)
	}
}
