//
//  FileManager-DocumentsDirectory.swift
//  BucketList
//
//  Created by Михаил Тихомиров on 04.08.2023.
//

import Foundation

// prepare our Storage to hold data there
extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
