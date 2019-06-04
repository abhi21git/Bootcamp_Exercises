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
        
        guard let url = URL(string: urlString) else{
            debugPrint("Failed to fetch data.");
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = RequestMethod.get.rawValue
        let session = URLSession(configuration: .ephemeral)
        let sessionTask = session.dataTask(with: request) { (responseData, response, error) in
            
            var result: Any?
            if error ==  nil {
                let decoder = JSONDecoder()
                result = try? decoder.decode([Employee].self, from: responseData!)
                completion(result, nil)
            } else {
                completion(nil, ServiceError.customError("Please check your internet connection and try again."))
            }
        }
        sessionTask.resume()
    }
    
    func loadSelectedEmployee(urlString: String, completion: @escaping((Any?, Error?) ->())) {
        
        guard let url = URL(string: urlString) else {
            print("Failed to fetch data.")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = RequestMethod.get.rawValue
        let session = URLSession.shared
        let sessionTask  = session.dataTask(with: request) {(responseData, response, error) in
            if error ==  nil {
                let result = try? JSONDecoder().decode(EmployeeDetails.self, from: responseData!)
                completion(result, nil)
            } else {
                completion(nil, ServiceError.customError("Couldn't fetch employee details."))
            }
        }
        sessionTask.resume()
    }
    
    func logIn(urlString: String, completion: @escaping((Any?, Error?) -> ())) {
        guard let url = URL(string: urlString) else {
            print("")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = RequestMethod.post.rawValue
//        request.setValue(String, forHTTPHeaderField: String)
    }

}
