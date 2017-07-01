//
//  SocketIOManager.swift
//  SharpeApp
//
//  Created by Thomas Fouan on 07/06/2017.
//  Copyright © 2017 Thomas Fouan. All rights reserved.
//

import UIKit

class SocketIOManager: NSObject {
	
	static let sharedInstance: SocketIOManager = SocketIOManager()
	
	var socket: SocketIOClient = SocketIOClient(socketURL: NSURL(string: "http://localhost:3000")! as URL)
	
	private override init() {
		super.init()
	}
	
	func establishConnection() {
		socket.connect()
		
		socket.on("connect") {data, ack in
			// Check if there is already a token in the local storage.
			// If yes, check its validity and redirect to UsersViewController of it is
			let token = AbstractRetriever.getToken()
			if(token != nil) {
				self.socket.emitWithAck("login", (token?.components(separatedBy: " ")[1])!).timingOut(after: 2, callback: { (data) in
					print("coucou + \(data) \n")
				})
			}
		}
	}
 
	func closeConnection() {
		socket.disconnect()
	}
	
	func login(token: String, callback: @escaping ([Any]) -> Void) {
		
		
	}
}
