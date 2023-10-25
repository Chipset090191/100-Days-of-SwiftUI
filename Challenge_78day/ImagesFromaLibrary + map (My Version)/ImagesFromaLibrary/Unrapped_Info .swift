//
//  Unrapped_Info .swift
//  ImagesFromaLibrary
//
//  Created by Михаил Тихомиров on 16.08.2023.
//

import Foundation
import SwiftUI
import CoreLocation


//struct ourImage: Hashable {
//    let image:Image
//}


struct Unrapped_Info: Identifiable,Equatable {
    
    var id: UUID
    var filename:String
    var image:Image
    var imagedata:Data
    
    var latitude: Double
    var longitude: Double
    
    var coordinate:CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
}
