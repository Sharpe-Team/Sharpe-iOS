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
	
	func establishConnection(navigationController: UINavigationController) {
		socket.connect()
		
		socket.on("connect") { data, ack in
			// Check if there is already a token in the local storage.
			// If yes, check its validity and redirect to UsersViewController of it is
			let token = StorageManager.getToken()
			
			// Send login event to be registered on the server
			if(token != nil) {
				self.socket.emit("login", token!)
				
				SwiftSpinner.show("Initialisation en cours")
				self.verifyToken(token: token!, navigationController: navigationController)
			} else {
				self.socket.emit("login")
			}
		}
	}
 
	func closeConnection() {
		socket.disconnect()
	}
	
	func login(token: String) {
		socket.emitWithAck("login", token).timingOut(after: 4) { (data) in
			if(!(data[0] is String && (data[0] as! String) == SocketAckStatus.noAck.rawValue)) {
				let userObj = data[0] as! Dictionary<String, AnyObject>
				StorageManager.storeUser(user: User(object: userObj))
			}
		}
	}
	
	func verifyToken(token: String, navigationController: UINavigationController) {
		socket.emitWithAck("verify-token", token).timingOut(after: 4, callback: { (data) in
			SwiftSpinner.hide()
			
			// If ack from server, get the user from ack and redirect to UserViewController => No need to reconnect
			if(!(data[0] is String && (data[0] as! String) == SocketAckStatus.noAck.rawValue)) {
				
				let userObj = data[0] as! Dictionary<String, AnyObject>
				StorageManager.storeUser(user: User(object: userObj))
				
				let usersController = UsersViewController()
				navigationController.pushViewController(usersController, animated: true)
			}
		})
	}
	
	func disconnect() {
		socket.emit("logout")
	}
	
	func newPrivatePoint(point: Point, idFriend: Int) {
		socket.emit("new-private-point", point, idFriend)
	}
}
