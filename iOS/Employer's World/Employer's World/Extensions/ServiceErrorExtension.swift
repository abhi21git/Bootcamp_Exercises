//
//  ServiceErrorExtension.swift
//  Employer's World
//
//  Created by Abhishek Maurya on 31/05/19.
//  Copyright © 2019 Abhishek Maurya. All rights reserved.
//

import Foundation

extension ServiceError {
    init(json: JSON) {
        if let message =  json["status_message"] as? String {
            self = .customError(message)
        } else {
            self = .other
        }
    }
}

extension ServiceError: LocalizedError {
    var errorDescription: String? {
        switch self {
//        case .noInternetConnection:
//            return "No Internet Connection."
        case .other:
            return "Something Went wrong."
        case .customError(let message):
            return message
        }
    }
}
