//
//  Images.swift
//  ImagesFromaLibrary
//
//  Created by Михаил Тихомиров on 14.08.2023.
//

import Foundation
import CoreLocation

struct Images: Identifiable, Codable, Comparable {

    
    var id: UUID
    var filename: String
    var imagedata: Data
    let latitude: Double
    let longitude: Double
    
    var coordinate:CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
//    static let example = Images(id: UUID(), filename: "test", imagedata: Data())
    
    
    static func < (lhs: Images, rhs: Images) -> Bool {
        lhs.filename < rhs.filename
    }
}
