//
//  Line.swift
//  SharpeApp
//
//  Created by Thomas Fouan on 02/07/2017.
//  Copyright © 2017 Thomas Fouan. All rights reserved.
//

import Foundation

class Line: NSObject {
	
	var id: Int?
	var idCircle: Int?
	var name: String?
	var annoucement: String?
	
	override init() {
	}
	
	init(object: Dictionary<String, AnyObject>) {
		self.id = object["id"] as? Int
		self.idCircle = object["idCircle"] as? Int
		self.name = object["name"] as? String
		self.annoucement = object["announcement"] as? String
	}
}
