//
//  TableCellModel.swift
//  RegisterTestApp
//
//  Created by Igor Zubko on 30.09.16.
//  Copyright © 2016 Igor Zubko. All rights reserved.
//

import UIKit

func ==(lhs: TableCellModel, rhs: TableCellModel) -> Bool {
	return lhs.title == rhs.title
		&& lhs.icon == lhs.icon
		&& lhs.keyboardType == lhs.keyboardType
		&& lhs.isSecure == lhs.isSecure
}

class TableCellModel: Hashable, Equatable {
	let title: String;
	let icon: String?;
	let keyboardType: UIKeyboardType
	let isSecure: Bool
	
	init(title: String, icon: String?, secure: Bool = false, keyboard: UIKeyboardType = .default) {
		self.title = title
		self.icon = icon
		self.keyboardType = keyboard
		self.isSecure = secure
	}
	
	var hashValue: Int {
		get {
			return "\(title) \(icon) \(keyboardType) \(isSecure)".hash
		}
	}
	

}
