//
//  User.swift
//  SharpeApp
//
//  Created by Thomas Fouan on 18/05/2017.
//  Copyright © 2017 Thomas Fouan. All rights reserved.
//

import Foundation

class User: NSObject {
	var id: Int?
	var firstname: String?
	var lastname: String?
	var email: String?
	var profilePicture: String?
	var admin: Int?
	
	init(firstname: String, lastname: String, email: String) {
		self.firstname = firstname
		self.lastname = lastname
		self.email = email
	}
	
	init(object: Dictionary<String, AnyObject>) {
		self.id = object["id"] as? Int
		self.firstname = object["firstname"] as? String
		self.lastname = object["lastname"] as? String
		self.email = object["email"] as? String
		self.profilePicture = object["profilePicture"] as? String
		self.admin = object["admin"] as? Int
	}
}
