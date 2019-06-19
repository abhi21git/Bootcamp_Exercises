//
//  GoogleImageModel.swift
//  Employer's World
//
//  Created by Abhishek Maurya on 19/06/19.
//  Copyright © 2019 Abhishek Maurya. All rights reserved.
//

import Foundation

struct imageData: Decodable {
    let title: String?
    let imageLink: String?
    let thumbnailLink: String?
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case imageLink = "link"
        case thumbnailLink = "thumbnailLink"
    }
}
