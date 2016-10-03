//
//  Settings.swift
//  RegisterTestApp
//
//  Created by Igor Zubko on 02.10.16.
//  Copyright © 2016 Igor Zubko. All rights reserved.
//

import Foundation

private enum Directories {
	static let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
}

private enum Keys {
	static let auth     = "auth" as NSCopying
	static let email    = "email"
	static let password = "password"
	
	static let userInfo  = "user" as NSCopying
	static let firstName = "firstName"
	static let lastName  = "lastName"
}

enum ConfigError: Error {
	case fileLoadingFailed
}

class Config {
	//MARK: - Static initializers
	static func load(callback: @escaping (Config) -> Void) {
		from(file: "config.plist", callback: callback)
	}
	
	static func from(file name: String, callback: @escaping (Config) -> Void) {
		DispatchQueue.global(qos: .default).async {
			let fname = Directories.documents.appendingPathComponent(name)
			let config = Config(file: fname)
			
			DispatchQueue.main.async {
				callback(config)
			}
		}
	}
	
	// MARK: -
	private let fname: URL
	private let queue = DispatchQueue(label: "xyz.kf.registerapp.config")
	
	var authorizationInfo: AuthorizationInfo? = nil
	var userInfo: UserInfo? = nil
	
	// MARK: -
	private init(file name: URL) {
		self.fname = name
		
		if let dict = NSDictionary(contentsOf: name) {
			let auth = AuthorizationInfo.from(config: dict)
			
			if auth != nil {
				self.authorizationInfo = auth
				self.userInfo = UserInfo.from(config: dict)
			}
		}
		
		NSLog("Config loaded from %@", name.absoluteString)
	}
	
	func clear() {
		self.authorizationInfo = nil
		self.userInfo = nil
	}
	
	func save(callback: @escaping () -> Void) {
		queue.async {
			let dict = NSMutableDictionary()
			self.authorizationInfo?.to(config: dict)
			self.userInfo?.to(config: dict)
			
			dict.write(to: self.fname, atomically: true)

//			// for testing purposes callback will be called after some delay
//			DispatchQueue.main.asyncAfter(deadline: .now() + 0.75, execute: {
//				callback()
//			})
			
			DispatchQueue.main.async {
				callback()
			}
		}
	}
}

private extension AuthorizationInfo {
	static func from(config: NSDictionary) -> AuthorizationInfo? {
		guard let values = config.object(forKey: Keys.auth) as? NSDictionary else {
			return nil
		}
		
		guard let email = values.object(forKey: Keys.email) as? String else {
			return nil
		}
		
		guard let password = values.object(forKey: Keys.password) as? String else {
			return nil
		}
		
		return AuthorizationInfo(email: email, password: password)
	}
	
	func to(config: NSMutableDictionary) {
		let values = [Keys.email:    self.email,
		              Keys.password: self.password]
		
		config.setObject(values, forKey: Keys.auth)
	}
}

private extension UserInfo {
	static func from(config: NSDictionary) -> UserInfo? {
		guard let values = config.object(forKey: Keys.userInfo) as? NSDictionary else {
			return nil
		}
		
		guard let firstName = values.object(forKey: Keys.firstName) as? String else {
			return nil
		}
		
		guard let lastName = values.object(forKey: Keys.lastName) as? String else {
			return nil
		}

		return UserInfo(firstName: firstName, lastName: lastName)
	}
	
	func to(config: NSMutableDictionary) {
		let values = [Keys.firstName: self.firstName,
		              Keys.lastName:  self.lastName]
		
		config.setObject(values, forKey: Keys.userInfo)
	}
}
