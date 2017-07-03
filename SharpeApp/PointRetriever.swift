//
//  LineRetriever.swift
//  SharpeApp
//
//  Created by Thomas Fouan on 02/07/2017.
//  Copyright © 2017 Thomas Fouan. All rights reserved.
//

import Foundation

class PointRetriever: AbstractRetriever {
	
	func getPoints(idLine: Int, callback: @escaping ([Point]) -> Void) {
		var points: [Point] = []
		
		let params = "idLine=\(idLine)"
		let url: URL = URL(string: API_URL + "/points?" + params)!
		var request = getRequestWithHeaders(url: url)
		request.httpMethod = "GET"
		
		let session = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: OperationQueue.main)
		
		let task = session.dataTask(with: request, completionHandler: {
			(data: Data?, response: URLResponse?, error: Error?) in
			
			if (error != nil) {
				callback(points)
			} else if (data != nil) {
				let httpResponse = response as? HTTPURLResponse
				
				do {
					// OK
					if(httpResponse?.statusCode == 200) {
						let itemList = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! Array<Dictionary<String, NSObject>>
						
						itemList.forEach({ (element) in
							let point: Point = Point(object: element)
							points.append(point)
						})
					} else { // KO
						let object = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! Dictionary<String, NSObject>
						print("object : \(String(describing: object["message"])) \n")
					}
					
					callback(points)
				} catch let errorEx {
					print(errorEx)
					callback(points)
				}
			}
		})
		task.resume()
	}
	
	func savePoint(text: String, idLine: Int, idUser: Int, created: Date, callback: @escaping (Point?) -> Void) {
		var savedPoint: Point? = nil
		let dateformatter: DateFormatter = DateFormatter()
		dateformatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
		
		var json:Dictionary<String, Any> = Dictionary()
		json.updateValue(idLine, forKey: "idLine")
		json.updateValue(idUser, forKey: "idUser")
		json.updateValue(text, forKey: "content")
		json.updateValue(dateformatter.string(from: created), forKey: "created")
		
		let jsonData = try? JSONSerialization.data(withJSONObject: json)
		
		let url: URL = URL(string: API_URL + "/points")!
		var request = getRequestWithHeaders(url: url)
		request.httpMethod = "POST"
		request.httpBody = jsonData
		
		let session = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: OperationQueue.main)
		
		let task = session.dataTask(with: request, completionHandler: {
			(data: Data?, response: URLResponse?, error: Error?) in
			
			if (error != nil) {
				callback(savedPoint)
			} else if (data != nil) {
				let httpResponse = response as? HTTPURLResponse
				
				do {
					let object = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! Dictionary<String, NSObject>
					
					// OK
					if(httpResponse?.statusCode == 201) {
						savedPoint = Point(object: object)
					} else { // KO
						print("object : \(String(describing: object["message"])) \n")
					}
					
					callback(savedPoint)
				} catch let errorEx {
					print(errorEx)
					callback(savedPoint)
				}
			}
		})
		task.resume()
	}
}
