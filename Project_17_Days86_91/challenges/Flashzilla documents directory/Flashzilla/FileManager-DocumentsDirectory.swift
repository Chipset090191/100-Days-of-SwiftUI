//
//  FileManager-DocumentsDirectory.swift
//  Flashzilla
//
//  Created by Михаил Тихомиров on 23.09.2023.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
