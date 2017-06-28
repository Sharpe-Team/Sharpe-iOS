//
//  SocketIOManager.swift
//  SharpeApp
//
//  Created by Thomas Fouan on 07/06/2017.
//  Copyright © 2017 Thomas Fouan. All rights reserved.
//

import UIKit

class SocketIOManager: NSObject {
	
	static let sharedInstance = SocketIOManager()
	
	var socket: SocketIOClient = SocketIOClient(socketURL: NSURL(string: "http://fouan.ddns.net:3000")! as URL)
	
	override init() {
		super.init()
	}
	
	func establishConnection() {
		socket.connect()
	}
 
	func closeConnection() {
		socket.disconnect()
	}
}
