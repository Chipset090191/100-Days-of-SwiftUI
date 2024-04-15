//
//  PlusButtonView.swift
//  ImagesFromLibrary
//
//  Created by Михаил Тихомиров on 08.04.2024.
//

import SwiftUI
import MapKit

struct PlusButtonView: View {
    
    // here we get through binding centerCoordinate(we get that from MapView)
    // here we grab through binding locations. But we just append element to our collection in "locations".
    
    
    @Binding var locations: [MKPointAnnotationCodable]
    @Binding var centerCoordinate:CLLocationCoordinate2D   // it includes latitude and longitude
    
    @State private var showingAlert = false
    
    var imageName:String
    
    var body: some View {
        Button {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            
            // Create new Location
            let newLocation = MKPointAnnotationCodable()
            newLocation.coordinate = self.centerCoordinate
            newLocation.title = "Location for Photo with name: \(self.imageName)"
            newLocation.subtitle = "Location added: \(formatter.string(from: Date()))"

            self.locations.append(newLocation)
            
        } label: {
            Image(systemName: "plus")
            
        }
        .modifier(DrawPlusButton())
        .disabled(imageName == "" ? true : false)
        .opacity(imageName == "" ? 0.5 : 1)
    }
}

//struct PlusButtonView_Previews: PreviewProvider {
//    static var previews: some View {
//        PlusButtonView()
//    }
//}

