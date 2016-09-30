//
// Created by Igor Zubko on 30.09.16.
// Copyright (c) 2016 Igor Zubko. All rights reserved.
//

import UIKit

extension UIView {
	func addBorderTop(size: CGFloat, color: UIColor, name: String?) {
		addBorder(x: 0, y: 0, width: frame.width, height: size, color: color, name: name)
	}
	
	func addBorderBottom(size: CGFloat, color: UIColor, name: String?) {
		addBorder(x: 0, y: frame.height - size, width: frame.width, height: size, color: color, name: name)
	}
	
	func removeBorders(name: String) {
		layer.sublayers?.filter { (el) -> Bool in
			return el.name == name
		} .forEach{ (el) in
			el.removeFromSuperlayer()
		}
	}
	
	private func addBorder(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, color: UIColor, name: String?) {
		let border = CALayer()
		border.name = name;
		border.backgroundColor = color.cgColor
		border.frame = CGRect(x: x, y: y, width: width, height: height)
		layer.addSublayer(border)
	}
}
