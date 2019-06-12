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
        let session = URLSession(configuration: .default)
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
    
    
    func emailValidation(urlString: String, userID: String, completion: @escaping((Any?, Error?) -> ())) {
        let parameters = ["mail" : userID]
        guard let url = URL(string: "https://qa.curiousworld.com/api/v2/Validate/Email?_format=json")
            else{
                return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            else {
                return
        }
        request.httpBody = httpBody
        let session = URLSession.shared
        
        let sessionTask = session.dataTask(with: request) { (data, response, error) in
            if error == nil {
                if let data = data {
                    do {
                        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? JSON{
                            if let status = json["status"] as? JSON {
                                guard let statusCode = status["code"] as? Int else {return}
                                completion(statusCode, nil)
                            }
                        }
                    } catch {
                        print(error)
                    }
                }
                
            }
            else {
                completion(nil , ServiceError.customError("Could not load Employees."))
            }
        }
        sessionTask.resume()
        
    }
    
    
    func logIn(urlString: String, userID: String, password: String, completion: @escaping((Any?, Error?) -> ())) {
        
        func getPostDataAttributes(params:[String:String]) -> Data {
            var data = Data()
            for(key, value) in params {
                let string = "--CuriousWorld\r\n".data(using: .utf8)
                data.append(string!)
                data.append(String.init(format: "Content-Disposition: form-data; name=%@\r\n\r\n", key).data(using: .utf8)!)
                data.append(String.init(format: "%@\r\n", value).data(using: .utf8)!)
                data.append(String.init(format: "--CuriousWorld--\r\n").data(using: .utf8)!)
            }
            return data
        }
        
        let loginParam = [
            "mail" : userID ,
            "password" : password,
            "client_secret" : "abcde12345",
            "client_id" : "ec7c3bde-9f51-4113-9ecf-6ca6fd03b66b",
            "scope" : "ios",
            "grant_type" : "password"]
        
        let parametersData = getPostDataAttributes(params: loginParam)
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("multipart/form-data; boundary=CuriousWorld", forHTTPHeaderField: "Content-Type")
        
        request.httpBody = parametersData
        let session = URLSession.shared
        
        let sessionTask = session.dataTask(with: request) { (data , response , error) in
            if error == nil {
                if let loginData = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: loginData, options: []) as? JSON
                        completion (json, nil)
                        
                    }
                    catch {
                        print(error)
                    }
                }
            }
            else {
                completion(nil , ServiceError.customError("Could not load Data."))
            }
        }
        sessionTask.resume()
    }
    
    
}
