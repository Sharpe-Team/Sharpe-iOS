//
//  LoginRetriever.swift
//  SharpeApp
//
//  Created by etudiant on 28/06/2017.
//  Copyright © 2017 Thomas Fouan. All rights reserved.
//

import Foundation
class LoginRetriever: AbstractRetriever {
    
    func login(username: String, password: String, callback: @escaping (String?, String?) -> Void) {
        
        let loginUrl = URL(string: API_URL + "/login")
        var urlRequest = URLRequest(url: loginUrl!)
        
        var json:Dictionary<String, Any> = Dictionary()
        json.updateValue(username, forKey: "username")
        json.updateValue(password, forKey: "password")
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = jsonData
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
		
		let session = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: OperationQueue.main)
		
        let task: URLSessionDataTask = session.dataTask(with: urlRequest, completionHandler: {
            (data: Data?, response: URLResponse?, error: Error?) in
			
			// Network error
			if(error != nil) {
				print("error = \(String(describing: error)) \n")
				callback(nil, error.debugDescription)
			} else if(data != nil) { // Response from server
				let httpResponse = response as? HTTPURLResponse
				
				// OK Http Status
				if(httpResponse?.statusCode == 200) {
					var token = httpResponse?.allHeaderFields["Authorization"] as? String
					// Remove header of token : "Bearer "
					// Split token with space
					token = token?.components(separatedBy: " ")[1]
					
					callback(token, nil)
				} else { // KO from server
					do {
						let object = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! Dictionary<String, NSObject>
						print("object : \(String(describing: object["message"])) \n")
						callback(nil, (object["message"] as? String))
					} catch let error {
						print("json parsing error : \(error) \n")
						callback(nil, error.localizedDescription)
					}
				}
			}
        })
		
        task.resume()
    }
}
