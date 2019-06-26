//
//  UIImageExtension.swift
//  Employer's World
//
//  Created by Abhishek Maurya on 19/06/19.
//  Copyright © 2019 Abhishek Maurya. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    
    //load image from a web url or from a local directory, searching by its name
    public static func loadFrom(url: String, completion: @escaping (_ image: UIImage?) -> ()) {
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: URL(string: url)!) {
                DispatchQueue.main.async {
                    completion(UIImage(data: data))
                }
            }
            else {
                DispatchQueue.main.async {
                    let documentDirectory = FileManager.SearchPathDirectory.documentDirectory
                    let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
                    let paths = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true).first
                    let path: String = paths!
                    //path has address of document directory and we need address of tmp directory where pictures are stored
                    
                    let dirPath = path.replacingOccurrences(of: "Documents", with: "tmp")
                    let imageURL = URL(fileURLWithPath: dirPath).appendingPathComponent("\(url)")
                    let image = UIImage(contentsOfFile: imageURL.path)
                    completion(image)
                }
            }
        }
    }
}
