//
//  Location.swift
//  BucketList
//
//  Created by Михаил Тихомиров on 29.07.2023.
//

import Foundation
import CoreLocation


// Equatable so as to equate two locations
struct Location: Identifiable, Codable, Equatable {
    
//    let id: UUID
    var id : UUID
    var name: String
    var description: String
    let latitude:Double
    let longitude:Double

    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    static let example = Location(id: UUID(), name: "Buckingham Palace", description: "Where Queen Elizabeth lives with her dorgis", latitude: 51.501, longitude: -0.141)
    
    
    // with this comparison we make our code agile and faster
    // Attention! - be quiet, if we use let id as previous we cannot change our array data! then we change it to - var
    static func ==(lhs: Location, rhs:Location) -> Bool {
        lhs.id == rhs.id
    }
}
