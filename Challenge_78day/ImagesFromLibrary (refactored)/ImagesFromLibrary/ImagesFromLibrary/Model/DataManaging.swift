//
//  DataManaging.swift
//  ImagesFromLibrary
//
//  Created by Михаил Тихомиров on 09.04.2024.
//

import Foundation
import SwiftUI


class DataManaging {
    
    enum AccessKey: String {
        case keyForPictures = "Pictures"
    }
    
    
    static func savePictureInfo(pathName: String, pictures: [PictureInfo]) {
        let filename = getDocumentsDirectory().appendingPathComponent(pathName)
        
        do {
            let data = try JSONEncoder().encode(pictures)
            try data.write(to: filename, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print("Unable to save data about Picture")
        }
        
    }
    

    static func loadPictureInfo(pathName: String) -> [PictureInfo] {
        let filename = getDocumentsDirectory().appendingPathComponent(pathName)
        
        do {
            let data = try Data(contentsOf: filename)
            let pictures = try JSONDecoder().decode([PictureInfo].self, from: data)
            return pictures
        } catch {
            print("Unable to load data about Picture")
        }
        return []
    }
    
    
    static func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    
}
