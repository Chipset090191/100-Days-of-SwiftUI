//
//  Unrapped_Info .swift
//  ImagesFromaLibrary
//
//  Created by Михаил Тихомиров on 16.08.2023.
//

import Foundation
import SwiftUI


//struct ourImage: Hashable {
//    let image:Image
//}


struct Unrapped_Info: Identifiable,Equatable {
    
    var id: UUID
    var filename:String
    var image:Image
    var imagedata:Data
    
}
