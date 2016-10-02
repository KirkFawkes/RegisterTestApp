//
//  String.swift
//  RegisterTestApp
//
//  Created by Igor Zubko on 02.10.16.
//  Copyright © 2016 Igor Zubko. All rights reserved.
//

import Foundation

class Validators {
	// NOTE: Not sure that this good idea to validate email in this way. Usually I just check with /.+@.+/ regex and confirmation email.
	//       See https://habrahabr.ru/post/280798/ , https://habrahabr.ru/post/175375/ for details
	static let email    = NSPredicate(format: "SELF MATCHES %@", "^[a-zA-Z0-9_.+-]{3,}@[a-zA-Z0-9-]{3,}\\.[a-zA-Z0-9-.]{2,}$")
	static let password = NSPredicate(format: "SELF MATCHES %@", "^.{5,}$")
}

func isValid(_ str: String?, predicate: NSPredicate) -> Bool? {
	return str.map { value in predicate.evaluate(with: value) }
}

extension String {
	func isValidEmail() -> Bool {
		return isValid(self, predicate: Validators.email)!
	}
	
	func isValidPassword() -> Bool {
		return isValid(self, predicate: Validators.password)!
	}
}
