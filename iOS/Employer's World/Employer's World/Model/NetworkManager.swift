//
//  NetworkController.swift
//  Employer's World
//
//  Created by Abhishek Maurya on 21/05/19.
//  Copyright © 2019 Abhishek Maurya. All rights reserved.
//

import Foundation

typealias JSON = [String: Any]

enum ServiceError: Error {
    //    case noInternetConnection
    case customError(String)
    case other
}

enum RequestMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}


class NetworkManager {
    
    static let sharedInstance = NetworkManager()
	
    
    func loadEmployee(urlString: String, completion: @escaping ((Any?,Error?) -> ())){
        
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = RequestMethod.get.rawValue
        let session = URLSession.shared
        let sessionTask = session.dataTask(with: request) { (data, response, error) in
            
            var result: Any?
            if error ==  nil {
                let decoder = JSONDecoder()
                result = try? decoder.decode([Employee].self, from: data!)
                completion(result, nil)
            }
            else {
                completion(nil, ServiceError.customError("Please check your internet connection and try again."))
            }
        }
        sessionTask.resume()
    }
    
    
    func loadSelectedEmployee(urlString: String, completion: @escaping((Any?, Error?) ->())) {
        
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = RequestMethod.get.rawValue
        let session = URLSession.shared
        let sessionTask  = session.dataTask(with: request) {(data, response, error) in
			
			if error ==  nil {
                let result = try? JSONDecoder().decode(EmployeeDetails.self, from: data!)
                completion(result, nil)
            }
            else {
                completion(nil, ServiceError.customError("Couldn't fetch employee details."))
            }
			
        }
        sessionTask.resume()
    }
    
	
	func logIn(urlString: String, parameters: Data, completion: @escaping((Any?, Error?) -> ())) {
		
		guard let url = URL(string: urlString) else {return}
		var request = URLRequest(url: url)
		
		request.httpMethod = RequestMethod.post.rawValue
		request.addValue("multipart/form-data; boundary=CuriousWorld", forHTTPHeaderField: "Content-Type")
		request.httpBody = parameters
		
		let session = URLSession.shared
		let sessionTask = session.dataTask(with: request) { (data , response , error) in
			
			if error == nil {
				do {
					let decoder = JSONDecoder()
					let model = try? decoder.decode(LoginModel.self, from: data!)
					completion(model , nil)
				}
				
			}
			else {
				completion(nil , ServiceError.customError("Could not login."))
			}
		}
		sessionTask.resume()
	}
    
	
    func profileApi(urlString: String, parameters: [String : String], completion: @escaping((Any?, Error?) -> ())) {
        
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        
        request.httpMethod = RequestMethod.post.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) else { return }
        
        request.httpBody = httpBody
        
        let session = URLSession.shared
        let sessionTask = session.dataTask(with: request) { (data, response, error) in
            
            if error == nil {
                do {
                    let decoder = JSONDecoder()
                    let model = try? decoder.decode(ProfileModel.self, from: data!)
                    completion(model , nil)
                }
				
            }
            else {
                completion(nil , ServiceError.customError("Please check your connection."))
            }
        }
        sessionTask.resume()
    }
	
	func googleImageSearch(parameters: [String : String], completion: @escaping((Any?, Error?) -> ())) {
		var querry: String?
		var start: String?
		var num: String?
		
		for (key, value) in parameters {
			if key == "querry" {
				querry = value
			}
			if key == "start" {
				start = value
			}
			if key == "num" {
				num = value
			}
		}
		
		guard let url = URL(string: "https://www.googleapis.com/customsearch/v1?q=\(String(describing: querry))&cx=014779335774980121077 %3Aj4u2pcebgfi&searchType=image&key=AIzaSyDFQJjdsS7BbaEUQYfbwOT93j00G O9kKQw&start=\(String(describing: start))&num=\(String(describing: num))") else { return }
		var request = URLRequest(url: url)

		request.httpMethod = RequestMethod.get.rawValue
		
		
	}
    
}
