//
//  String.swift
//  RegisterTestApp
//
//  Created by Igor Zubko on 02.10.16.
//  Copyright © 2016 Igor Zubko. All rights reserved.
//

import Foundation

class Validator {
	// NOTE: Not sure that this good idea to validate email in this way. Usually I just check with /.+@.+/ regex and confirmation email.
	//       See https://habrahabr.ru/post/280798/ , https://habrahabr.ru/post/175375/ for details
	static private let emailRegex = "^[a-zA-Z0-9_.+-]{3,}@[a-zA-Z0-9-]{3,}\\.[a-zA-Z0-9-.]{2,}$"
	static private let emailPredicate = NSPredicate(format: "SELF MATCHES %@", Validator.emailRegex)
	
	static private let passwordRegex = "^.{5,}$"
	static private let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", Validator.passwordRegex)
	
	static func isValidEmail(email: String?) -> Bool {
		return self.emailPredicate.evaluate(with: email ?? "")
	}
	
	static func isValidPassword(password: String?) -> Bool {
		return self.passwordPredicate.evaluate(with: password ?? "")
	}
}


extension String {
	func isValidEmail() -> Bool {
		return Validator.isValidEmail(email: self)
	}
	
	func isValidPassword() -> Bool {
		return Validator.isValidPassword(password: self)
	}
}
