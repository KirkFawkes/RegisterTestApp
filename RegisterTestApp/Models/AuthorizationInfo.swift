//
//  AuthorizationModel.swift
//  RegisterTestApp
//
//  Created by Igor Zubko on 02.10.16.
//  Copyright © 2016 Igor Zubko. All rights reserved.
//

import Foundation

class AuthorizationInfo: CustomStringConvertible {
	let email: String
	let password: String
	
	init(email: String, password: String) {
		self.email = email
		self.password = password
	}
	
	var description: String {
		return "[email]: \(email); [password]: \(password)"
	}
}
