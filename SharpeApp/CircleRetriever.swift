//
//  CircleRetriever.swift
//  SharpeApp
//
//  Created by Thomas Fouan on 02/07/2017.
//  Copyright © 2017 Thomas Fouan. All rights reserved.
//

import Foundation

class CircleRetriever: AbstractRetriever {
	
	func getCircle(idUser: Int, callback: @escaping (Circle?) -> Void) {
		var circle: Circle?
		
		let user: User = StorageManager.getUser()
		let id: Int = user.id!
		
		let params = "idUser1=\(id)&idUser2=\(idUser)"
		let url: URL = URL(string: API_URL + "/circles/private?" + params)!
		var request = getRequestWithHeaders(url: url)
		request.httpMethod = "GET"
		
		let session = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: OperationQueue.main)
		
		let task = session.dataTask(with: request, completionHandler: {
			(data: Data?, response: URLResponse?, error: Error?) in
			
			if (error != nil) {
				callback(circle)
			} else if (data != nil) {
				let httpResponse = response as? HTTPURLResponse
				
				do {
					let object = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! Dictionary<String, NSObject>
					
					// OK
					if(httpResponse?.statusCode == 200) {
						circle = Circle(object: object)
					} else {
						print("object : \(String(describing: object["message"])) \n")
					}
					
					callback(circle)
				} catch let errorEx {
					print(errorEx)
					callback(circle)
				}
			}
		})
		task.resume()
	}
}
