//
//  UserRetriever.swift
//  SharpeApp
//
//  Created by Thomas Fouan on 28/06/2017.
//  Copyright © 2017 Thomas Fouan. All rights reserved.
//

import Foundation

class UserRetriever: AbstractRetriever {
	
	func getAllUsers(callback: @escaping ([User]) -> Void) {
		var users: [User] = []
		
		let url: URL = URL(string: API_URL + "/users")!
		var request = getRequestWithHeaders(url: url)
		
		/*
		var json: Dictionary<String, Any> = Dictionary()
		json.updateValue("value", forKey: "key")
		let jsonData = try? JSONSerialization.data(withJSONObject: json)
		
		request.httpMethod = "POST"
		request.httpBody = jsonData
		*/
		
		request.httpMethod = "GET"
		
		let session = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: OperationQueue.main)
		
		let task = session.dataTask(with: request, completionHandler: {
			(data: Data?, response: URLResponse?, error: Error?) in
			
			if (error != nil) {
				callback(users)
			} else if (data != nil) {
				do {
					let itemList = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! Array<Dictionary<String, NSObject>>
					
					// Convert itemList to [User]
					itemList.forEach({ (object) in
						let user: User = User(object: object)
						users.append(user)
					})
					
					callback(users)
				} catch let errorEx {
					callback(users)
				}
			}
		})
		task.resume()
	}
}
