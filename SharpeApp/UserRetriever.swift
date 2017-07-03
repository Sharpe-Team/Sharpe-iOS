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
		request.httpMethod = "GET"
		
		let session = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: OperationQueue.main)
		
		let task = session.dataTask(with: request, completionHandler: {
			(data: Data?, response: URLResponse?, error: Error?) in
			
			if (error != nil) {
				callback(users)
			} else if (data != nil) {
				let httpResponse = response as? HTTPURLResponse
				
				do {
					// OK
					if(httpResponse?.statusCode == 200) {
						let itemList = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! Array<Dictionary<String, NSObject>>
						
						// Convert itemList to [User]
						itemList.forEach({ (element) in
							let user: User = User(object: element)
							users.append(user)
						})
					} else { // KO
						let object = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! Dictionary<String, NSObject>
						print("object : \(String(describing: object["message"])) \n")
					}
					
					callback(users)
				} catch let errorEx {
					print(errorEx)
					callback(users)
				}
			}
		})
		task.resume()
	}
}
