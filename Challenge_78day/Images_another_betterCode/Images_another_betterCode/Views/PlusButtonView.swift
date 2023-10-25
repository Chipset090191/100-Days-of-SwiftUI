//
//  PlusButtonView.swift
//  Images_another_betterCode
//
//  Created by Михаил Тихомиров on 20.08.2023.
//

import SwiftUI
import MapKit

struct PlusButtonView: View {
    
    // here we get through binding centerCoordinate(we get that from MapView)
    // here we grab through binding locations. But we just append element to our collection in "locations".
    
    
    @Binding var locations: [CodableMKPointAnnotation]
    @Binding var centerCoordinate:CLLocationCoordinate2D   // it includes latitude and longitude
    
    var imageName:String
    
    var body: some View {
        Button {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            
            // Create new Location
            let newLocation = CodableMKPointAnnotation()
            newLocation.coordinate = self.centerCoordinate
            newLocation.title = "Location for Photo with name: \(self.imageName)"
            newLocation.subtitle = "Location added: \(formatter.string(from: Date()))"
            self.locations.append(newLocation)
            
        } label: {
            Image(systemName: "plus")
            
        }
        .modifier(DrawPlusButton())

    }
}

//struct PlusButtonView_Previews: PreviewProvider {
//    static var previews: some View {
//        PlusButtonView()
//    }
//}
