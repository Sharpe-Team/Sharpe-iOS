//
//  User.swift
//  SharpeApp
//
//  Created by Thomas Fouan on 18/05/2017.
//  Copyright © 2017 Thomas Fouan. All rights reserved.
//

import Foundation

class User: NSObject, NSCoding {
	var id: Int?
	var firstname: String?
	var lastname: String?
	var email: String?
	var profilePicture: String?
	var admin: Int?
	
	override init() {
		
	}
	
	init(id: Int, firstname: String?, lastname: String?, email: String?, profilePicture: String?, admin: Int) {
		self.id = id
		self.firstname = firstname
		self.lastname = lastname
		self.email = email
		self.profilePicture = profilePicture
		self.admin = admin
	}
	
	init(object: Dictionary<String, AnyObject>) {
		self.id = object["id"] as? Int
		self.firstname = object["firstname"] as? String
		self.lastname = object["lastname"] as? String
		self.email = object["email"] as? String
		self.profilePicture = object["profilePicture"] as? String
		self.admin = object["admin"] as? Int
	}
	
	required convenience init(coder aDecoder: NSCoder) {
		let id = aDecoder.decodeInteger(forKey: "id")
		let firstname = aDecoder.decodeObject(forKey: "firstname") as? String
		let lastname = aDecoder.decodeObject(forKey: "lastname") as? String
		let email = aDecoder.decodeObject(forKey: "email") as? String
		let profilePicture = aDecoder.decodeObject(forKey: "profilePicture") as? String
		let admin = aDecoder.decodeInteger(forKey: "admin")
		
		self.init(id: id, firstname: firstname, lastname: lastname, email: email, profilePicture: profilePicture, admin: admin)
	}
	
	func encode(with aCoder: NSCoder) {
		aCoder.encode(id, forKey: "id")
		aCoder.encode(firstname, forKey: "firstname")
		aCoder.encode(lastname, forKey: "lastname")
		aCoder.encode(email, forKey: "email")
		aCoder.encode(profilePicture, forKey: "profilePicture")
		aCoder.encode(admin, forKey: "admin")
	}
}
