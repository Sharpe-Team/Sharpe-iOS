//
//  Circle.swift
//  SharpeApp
//
//  Created by Thomas Fouan on 02/07/2017.
//  Copyright © 2017 Thomas Fouan. All rights reserved.
//

import Foundation

class Circle: NSObject {
	
	var id: Int?
	var name: String?
	var pictureUrl: String?
	var bannerPictureUrl: String?
	var lines: [Line]?
	var type: Int?
	
	override init() {
	}
	
	init(object: Dictionary<String, AnyObject>) {
		self.id = object["id"] as? Int
		self.name = object["name"] as? String
		self.pictureUrl = object["pictureUrl"] as? String
		self.bannerPictureUrl = object["bannerPictureUrl"] as? String
		self.type = object["type"] as? Int
		
		var lines: [Line] = []
		let array = (object["lines"] as! NSArray) as Array
		array.forEach { (element) in
			let line: Line = Line(object: (element as? Dictionary<String, AnyObject>)!)
			lines.append(line)
		}
		self.lines = lines
	}
	
}
