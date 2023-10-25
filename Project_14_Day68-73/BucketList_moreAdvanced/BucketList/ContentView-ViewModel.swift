//
//  ContentView-ViewModel.swift
//  BucketList
//
//  Created by Михаил Тихомиров on 03.08.2023.
//

import Foundation
import LocalAuthentication
import MapKit


extension ContentView {
    
    // MainActor is responsible for running all user interface
    // ui updates must happen on the main actor
    
    @MainActor class ViewModel: ObservableObject {  // we are saying that ViewModel it is for our ContentView
        
        @Published var mapRegion = MKCoordinateRegion (center: CLLocationCoordinate2D(latitude: 50, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25)) // span is for zooming
        
        @Published private(set) var locations: [Location] // we declare just [locations] instead of [location] () because our init define itself
    
        @Published  var selectedPlace: Location?  // whether you selected smth. or not
        
        @Published var isUnlocked = false // authentication
        
        @Published var showingAlert = false
        
        @Published var message = ""
        
        
        
        let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedPlaces") // here we added name of our repository in "documentsDirectory" so swift know where to read and write data
        
        // to load our data from documentsDirectory
        init() {
            do {
                let data = try Data(contentsOf: savePath) // go through our Path
                locations = try JSONDecoder().decode([Location].self, from: data)
            } catch {
                locations = []
            }
        }
        
        // saving data to our repository "SavedPlaces" in documentsDirectory
        func save() {
            do {
                let data = try JSONEncoder().encode(locations)
                try data.write(to: savePath, options: [.atomicWrite, .completeFileProtection])  // we write it when device is unlocked
            } catch {
                print ("Unable to save data.")
            }
        }
        
        
        func addLocation() {
            // create a new location
            let newLocation = Location(id: UUID(), name: "New location", description: "", latitude: mapRegion.center.latitude, longitude: mapRegion.center.longitude)
            locations.append(newLocation)
            save() // we save our location when we add it
            
        }
        
        
        func update(location: Location) {
            
            guard let selectedPlace = selectedPlace else { return }
            
            
            if let index = locations.firstIndex(of: selectedPlace) {
                locations[index] = location
                save() // we save our location when we`ve changed that
            }
        }
        
        func authenticate() {
            let context = LAContext()
            var error: NSError?

            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                let reason = "Please authenticate yourself to unlock your places." // that is reason for face id
                
                
               
           //! THIS code won`t be running under MainActor.(problem of publishing changes from background threads). Below the answer how to fix it
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                    
                    if success {
// we make a Task with @MainActor and run the code for MainActor
                        Task{ @MainActor in
                            self.isUnlocked = true
                        }
//                        self.isUnlocked = true   // we put it from here to Task of await MainActor

                    } else {
                        Task {
                            @MainActor in
                            self.showingAlert = true
                            self.message = authenticationError?.localizedDescription ?? "No error"
                            
                        }
                        
                    }
                    
//                    if (authenticationError != nil) {
//                        print (authenticationError!.localizedDescription)
//                    }
                    
                }
            //!
            } else {
                // no biometrics
            }
            
            
        }
        
        
    }
}

