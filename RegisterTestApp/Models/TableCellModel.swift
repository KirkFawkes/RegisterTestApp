//
//  TableCellModel.swift
//  RegisterTestApp
//
//  Created by Igor Zubko on 30.09.16.
//  Copyright © 2016 Igor Zubko. All rights reserved.
//

import UIKit

class TableCellModel {
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
}
