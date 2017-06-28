//
//  LoginRetriever.swift
//  SharpeApp
//
//  Created by etudiant on 28/06/2017.
//  Copyright © 2017 Thomas Fouan. All rights reserved.
//

import Foundation
class LoginRetriever: NSObject {
    
    let API_URL: String = "https://fouan.ddns.net:8443"
    
    func login(username: String, password: String, callback: @escaping (Bool) -> Void) {
        
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
        
        let task: URLSessionDataTask = URLSession.shared.dataTask(with: urlRequest, completionHandler: {
            (data: Data?, response: URLResponse?, error: Error?) in
            
            if let httpResponse = response as? HTTPURLResponse, let token = httpResponse.allHeaderFields["Authorization"] as? String {
                
                UserDefaults.standard.set(token, forKey: "token")
                callback(true)
            }
            
            callback(false)
        })
        
        task.resume()
    }
}
