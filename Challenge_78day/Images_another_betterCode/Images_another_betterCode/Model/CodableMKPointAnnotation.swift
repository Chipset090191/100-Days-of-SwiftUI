//
//  CodableMKPointAnnotation.swift
//  Images_another_betterCode
//
//  Created by Михаил Тихомиров on 20.08.2023.
//

import Foundation
import MapKit

class CodableMKPointAnnotation: MKPointAnnotation, Codable {
    
    enum CodingKeys: CodingKey {
        case title, subtitle, latitude, longitude, test
    }
    
    override init() {   // when we override init() here we say that the logic of superclass - MKPointAnnotation will be executed firstly -
        super.init()    // - and then we execute the logic of subclass
    }
    
    
    
    public required init(from decoder: Decoder) throws {
        super.init() // - here we manually tell swift to use firstly the logic of super class to get a self contant
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        subtitle = try container.decode(String.self, forKey: .subtitle)
         
        
        let latitude = try container.decode(CLLocationDegrees.self, forKey: .latitude)
        let longitude = try container.decode(CLLocationDegrees.self, forKey: .longitude)
        coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(title, forKey: .title)
        try container.encode(subtitle, forKey: .subtitle)
        try container.encode(coordinate.latitude, forKey: .latitude)
        try container.encode(coordinate.longitude, forKey: .longitude)

    }
}



