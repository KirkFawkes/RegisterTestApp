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
		&& lhs.type == lhs.type
}

enum TableCellType {
	case email
	case password
	case firstName
	case lastName
}

class TableCellModel: Hashable, Equatable {
	let title: String;
	let icon: String?;
	let type: TableCellType
	
	// computed properties
	let keyboardType: UIKeyboardType
	let isSecure: Bool
	
	init(title: String, icon: String?, type: TableCellType) {
		self.title = title
		self.icon = icon
		self.type = type
		
		self.isSecure = (type == .password)
		
		switch type {
		case .email:
			keyboardType = .emailAddress
			
		case .password:
			keyboardType = .asciiCapable
			
		case .firstName, .lastName:
			keyboardType = .default
		}
	}
	
	var hashValue: Int {
		get {
			return "\(title) \(icon) \(type)".hash
		}
	}
	

}
