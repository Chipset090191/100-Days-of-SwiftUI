//
//  FileManager-DocumentsDirectory.swift
//  HotProspects
//
//  Created by Михаил Тихомиров on 04.09.2023.
//

import Foundation

extension FileManager {
    
    static var documentsirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
