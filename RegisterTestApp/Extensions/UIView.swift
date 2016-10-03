//
// Created by Igor Zubko on 30.09.16.
// Copyright (c) 2016 Igor Zubko. All rights reserved.
//

import UIKit

enum BorderTags {
	static let top    = -8911
	static let bottom = -8912
}

extension UIView {
	func addBorderTop(size: CGFloat, color: UIColor) {
		addBorder(x: 0, y: 0, width: frame.width, height: size, color: color, tag: BorderTags.top)
	}
	
	func addBorderBottom(size: CGFloat, color: UIColor) {
		addBorder(x: 0, y: frame.height - size, width: frame.width, height: size, color: color, tag: BorderTags.bottom)
	}
	
	func removeBorders() {
		removeTopBorder()
		removebottomBorder()
	}
	
	func removeTopBorder() {
		removeBorders(tag: BorderTags.top)
	}
	
	func removebottomBorder() {
		removeBorders(tag: BorderTags.bottom)
	}
	
	private func removeBorders(tag: Int) {
		self.subviews.filter {$0.tag == tag} .forEach { $0.removeFromSuperview() }
	}
	
	private func addBorder(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, color: UIColor, tag: Int) {
		let borderView = UIView(frame: CGRect(x: x, y: y, width: width, height: height))
		borderView.backgroundColor = color
		borderView.translatesAutoresizingMaskIntoConstraints = true
		borderView.tag = tag
		self.addSubview(borderView)
		
		borderView.autoresizingMask = .flexibleWidth
		
//		let border = CALayer()
//		border.name = name;
//		border.backgroundColor = color.cgColor
//		border.frame = CGRect(x: x, y: y, width: width, height: height)
//		layer.addSublayer(border)
	}
}
