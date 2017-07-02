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
				do {
					let itemList = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! Array<Dictionary<String, NSObject>>
					
					itemList.forEach({ (element) in
						let point: Point = Point(object: element)
						points.append(point)
					})
					
					callback(points)
				} catch let errorEx {
					print(errorEx)
					callback(points)
				}
			}
		})
		task.resume()
	}
}
