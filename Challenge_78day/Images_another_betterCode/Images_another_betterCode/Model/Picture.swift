//
//  Picture.swift
//  Images_another_betterCode
//
//  Created by Михаил Тихомиров on 20.08.2023.
//

import Foundation

struct Picture: Codable,Identifiable {
    
    var id: UUID
    var pictureName:String
    var locations:[CodableMKPointAnnotation]
}
