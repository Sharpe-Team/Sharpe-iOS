//
//  AbstractRetriever.swift
//  SharpeApp
//
//  Created by Thomas Fouan on 28/06/2017.
//  Copyright © 2017 Thomas Fouan. All rights reserved.
//

import Foundation

class AbstractRetriever: NSObject {

	public let API_URL: String = "https://localhost:8443" //"https://fouan.ddns.net:8443"
	
	func getToken() -> String {
		return UserDefaults.standard.string(forKey: "token")!;
	}
	
	func getRequestWithHeaders(url: URL) -> URLRequest {
		var request: URLRequest = URLRequest(url: url)
		
		request.addValue("application/json", forHTTPHeaderField: "Content-type")
		request.addValue("application/json", forHTTPHeaderField: "Accept")
		request.setValue("Bearer " + getToken(), forHTTPHeaderField: "Authorization")
		
		return request
	}
}

extension AbstractRetriever: URLSessionDelegate {
	
	public func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
		completionHandler(URLSession.AuthChallengeDisposition.useCredential, URLCredential(trust: challenge.protectionSpace.serverTrust!))
	}
}
