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
    
    static let sharedInstance = NetworkManager() // to make this class singleton
	
	
	// function which will load employees
    func loadEmployees(urlString: String, completion: @escaping ((Any?,Error?) -> ())){
        
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
		
        request.httpMethod = RequestMethod.get.rawValue
		
        let session = URLSession.shared
        let sessionTask = session.dataTask(with: request) { (data, response, error) in
            
            if error ==  nil {
                let result = try? JSONDecoder().decode([EmployeeDetails].self, from: data!)
                completion(result, nil)
            }
            else {
                completion(nil, ServiceError.customError("Please check your internet connection"))
            }
        }
        sessionTask.resume()
    }
    
	
	//function which will load details of specific employee
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
    
	
	//function which will give response of login API
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
    
	
	//function which will give response of validation, forget and signup api
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
	
	
	//functon which will give response from google custom search api
	func googleImageSearch(urlString: String, completion: @escaping((Any?, Error?) -> ())) {

		guard let url = URL(string: urlString) else { return }
		var request = URLRequest(url: url)

		request.httpMethod = RequestMethod.get.rawValue
		
		let session = URLSession.shared
		let sessionTask = session.dataTask(with: request) { (data, response, error) in
			
			var result: Any?
			if error ==  nil {
				let decoder = JSONDecoder()
				result = try? decoder.decode(GoogleImages.self, from: data!)
				completion(result, nil)
			}
			else {
				completion(nil, ServiceError.customError("Please check your internet connection and try again."))
			}
		}
		sessionTask.resume()
	}

    
}
