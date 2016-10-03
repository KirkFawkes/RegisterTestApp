//
//  Userinfo.swift
//  RegisterTestApp
//
//  Created by Igor Zubko on 03.10.16.
//  Copyright © 2016 Igor Zubko. All rights reserved.
//

import Foundation

class UserInfo: CustomStringConvertible {
	let firstName: String
	let lastName: String
	
	init(firstName: String, lastName: String) {
		self.firstName = firstName
		self.lastName = lastName
	}
	
	var description: String {
		return "[name]: \(lastName), \(firstName)"
	}
}
