//
//  User.swift
//  SharpeApp
//
//  Created by Thomas Fouan on 18/05/2017.
//  Copyright © 2017 Thomas Fouan. All rights reserved.
//

import Foundation

class User: NSObject {
	var firstname: String?
	var lastname: String?
	var email: String?
	var pictureUrl: String?
	
	init(firstname: String, lastname: String, email: String) {
		self.firstname = firstname
		self.lastname = lastname
		self.email = email
	}
}
