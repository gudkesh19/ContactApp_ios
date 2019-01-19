//
//  ImageFileManager.swift
//  ContactsApp
//
//  Created by Gudkesh Kumar on 28/12/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import UIKit

final class ImageFileManager {
    
    static func save( _ image: UIImage, imageName: String) {
        let fileManager = FileManager.default
        let imagePath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(imageName)
        let data = image.pngData()
        fileManager.createFile(atPath: imagePath as String, contents: data, attributes: nil)
    }
    
    static func getImage(withName name: String) -> UIImage? {
        
        let imagePath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(name)
        return UIImage(contentsOfFile: imagePath)
        
    }
    
    static func deleteImage(withName name: String) {
        let fileManager = FileManager.default
        let imagePath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(name)
        if fileManager.fileExists(atPath: imagePath){
            try? fileManager.removeItem(atPath: imagePath)
        }else{
            print("Could not delete the contact image.")
        }
    }
}
