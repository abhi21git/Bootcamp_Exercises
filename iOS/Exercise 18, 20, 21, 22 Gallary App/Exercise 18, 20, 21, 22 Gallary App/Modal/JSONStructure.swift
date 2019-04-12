//
//  JSONStructure.swift
//  Exercise 18, 20, 21, 22 Gallary App
//
//  Created by Abhishek Maurya on 08/04/19.
//  Copyright © 2019 Abhishek Maurya. All rights reserved.
//

import Foundation

struct jsonStructure : Decodable {
    let id: Int
    let author: String
    let author_url: String
}
