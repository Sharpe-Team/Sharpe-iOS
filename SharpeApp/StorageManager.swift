//
//  StorageManager.swift
//  SharpeApp
//
//  Created by Thomas Fouan on 02/07/2017.
//  Copyright © 2017 Thomas Fouan. All rights reserved.
//

import Foundation

class StorageManager: NSObject {
	
	static func clearStorage() {
		let appDomain = Bundle.main.bundleIdentifier!
		UserDefaults.standard.removePersistentDomain(forName: appDomain)
	}
	
	static func storeToken(token: String) {
		UserDefaults.standard.set(token, forKey: "token")
	}
	
	static func getToken() -> String? {
		return UserDefaults.standard.string(forKey: "token")
	}
	
	static func storeUser(user: User) {
		let data: Data? = NSKeyedArchiver.archivedData(withRootObject: user)
		UserDefaults.standard.set(data, forKey: "user")
	}
	
	static func getUser() -> User {
		let data = UserDefaults.standard.data(forKey: "user")
		return NSKeyedUnarchiver.unarchiveObject(with: data!) as! User
	}
}
