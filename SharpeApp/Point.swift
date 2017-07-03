//
//  Point.swift
//  SharpeApp
//
//  Created by Thomas Fouan on 02/07/2017.
//  Copyright © 2017 Thomas Fouan. All rights reserved.
//

import Foundation

class Point: NSObject, SocketData {
	var id: Int?
	var idLine: Int
	var idUser: Int
	var content: String
	var created: Date
	var user: User?
	
	init(idLine: Int, idUser: Int, content: String, created: Date) {
		self.idLine = idLine
		self.idUser = idUser
		self.content = content
		self.created = created
	}
	
	init(object: Dictionary<String, AnyObject>) {
		self.id = object["id"] as? Int
		self.idLine = object["idLine"] as! Int
		self.idUser = object["idUser"] as! Int
		self.content = object["content"] as! String
		
		self.created = Date(timeIntervalSince1970: (object["created"] as? Double)!/1000)
		self.user = User(object: (object["user"] as? Dictionary<String, AnyObject>)!)
	}
	
	func socketRepresentation() -> SocketData {
		return [
			"id": id!,
			"idLine": idLine,
			"idUser": idUser,
			"content": content,
			"created": created.timeIntervalSince1970*1000,
			"user": user?.toDictionnary()
		]
	}
}
