//
//  GoogleImageModel.swift
//  Employer's World
//
//  Created by Abhishek Maurya on 19/06/19.
//  Copyright © 2019 Abhishek Maurya. All rights reserved.
//

import Foundation

struct GoogleImages: Decodable {
    let items: [ImageData]?
    
    enum CodingKeys: String, CodingKey {
        case items = "items"
    }
}

struct ImageData: Decodable {
    let title: String?
    let imageLink: String?
    let image: ImageDetails?
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case imageLink = "link"
        case image = "image"
    }
}

struct ImageDetails: Decodable {
    let thumbnailLink: String?
    
    enum CodingKeys: String, CodingKey {
        case thumbnailLink = "thumbnailLink"
    }
}
