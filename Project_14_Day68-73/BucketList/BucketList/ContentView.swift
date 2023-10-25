//
//  ContentView.swift
//  BucketList
//
//  Created by Михаил Тихомиров on 27.07.2023.
//


import SwiftUI
import MapKit


struct ContentView: View {
    
    @State private var mapRegion = MKCoordinateRegion (center: CLLocationCoordinate2D(latitude: 50, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25)) // span is for zooming
    
    @State private var locations = [Location]()
    
    
    @State private var selectedPlace: Location?  // whether you selected smth. or not
    
    
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: $mapRegion, annotationItems: locations) { location in
                // instead of using MapMarker we are gonna use MapAnnotation
                MapAnnotation(coordinate: location.coordinate) {
                    VStack {
                        Image(systemName: "star.fill")
                            
                            .foregroundColor(.red)
                            .frame(width: 44, height: 44)  // 44 - that`s a magic number. Reccomended minimum number for size  for Apple
                            .background(.black)
                            .clipShape(Circle())
                            
                        
                        Text (location.name)
                            .fixedSize()  // we are sure our text won`t be shortened no matter how big it is
                    }
                    .onTapGesture {
                        selectedPlace = location
                    }
                }
            }
                .ignoresSafeArea()
            
            // that`s our central point on the map
            Circle()
                .fill(.blue)
                .opacity(0.3)
                .frame(width: 32, height: 32)
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button {
                        // create a new location
                        
                        let newLocation = Location(id: UUID(), name: "New location", description: "", latitude: mapRegion.center.latitude, longitude: mapRegion.center.longitude)
                        locations.append(newLocation)
                            
                    }label: {
                        Image(systemName: "plus")
                    }
                    .padding()
                    .background(.black.opacity(0.75))
                    .foregroundColor(.white)
                    .font(.title)
                    .clipShape(Circle())
                    .padding(.trailing)
                }
            }
        }
        .sheet(item: $selectedPlace) { place in   // place here is unwrapped version. Attention!
            EditView(location: place) { newLocation in
                if let index = locations.firstIndex(of: place) {
                    locations[index] = newLocation
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
