//
//  ContentView_ViewModel.swift
//  ImagesFromaLibrary
//
//  Created by Михаил Тихомиров on 14.08.2023.
//

import Foundation
import UIKit
import SwiftUI
import CoreLocation
import MapKit
import LocalAuthentication

extension ContentView {
    
    @MainActor class ViewModel: ObservableObject {
        
        @Published var image: Image?
        @Published var name = ""
        @Published var imagedata:Data?
        

        
        @Published var locationFetcher = LocationFetcher()
        
        @Published var isUnlocked = false // authentication
        

        
        @Published private(set) var imagesInfo:[Images]
        
        @Published var presentationOfImage = [Unrapped_Info]()
    
        @Published var currentLocation = CLLocationCoordinate2D()
        
        @Published var map = MKCoordinateRegion()
        
        @Published var inputImage:UIImage?
        @Published var showingImagePicker = false
        @Published var showingPreviewDialog = false
        
        @Published var del: UUID = UUID()
        
        
        
        
        let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedInfo")
        
        
        
        init() {
            do {
                let data = try Data(contentsOf: savePath)
                let items = try JSONDecoder().decode([Images].self, from: data)
                
                imagesInfo = items.sorted()
                
                formingUIImageArray()
            } catch {
                imagesInfo = []
            }
        }
            
//            do {
//                let data2 = try Data(contentsOf: savePath2)
//
//            }
        
        
        func authenticate(){
            let context = LAContext()
            var error: NSError?

            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                let reason = "Please authenticate yourself to unlock your places." // that is reason for face id
                
                
               
           //! THIS code won`t be running under MainActor.(problem of publishing changes from background threads). Below the answer how to fix it
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                    
                    if success {
// we make a Task with @MainActor and run the code for MainActor
//                        Task{ @MainActor in
//                            self.isUnlocked = true
//                        }
//                        self.isUnlocked = true   // we put it from here to Task of await MainActor

                    } else {
//                        Task {
//                            @MainActor in
//                            self.showingAlert = true
//                            self.message = authenticationError?.localizedDescription ?? "No error"
//
//                        }
                        
                    }
 
                }
            //!
            } else {
                // no biometrics
            }
            
            
        }
        
        
        
        
        
        func pickedImage() {
            
            guard let inputImage = inputImage else { return }
            image = Image(uiImage: inputImage)
            
        
            if let jpegData = inputImage.jpegData(compressionQuality: 0.8) {
                imagedata = jpegData
            }
            
            // fetching location here
            if let location = self.locationFetcher.lastKnownLocation {
                print("Your location is \(location)")
                currentLocation = location
                map = MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25))
            } else {
                currentLocation = CLLocationCoordinate2D(latitude: 50, longitude: 0)
                map = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 50, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25))
            }
            
            
            
                // then code for getting coordinates
//            if let imageData = inputImage.jpegData(compressionQuality: 1.0),
//               let imageSource = CGImageSourceCreateWithData(imageData as CFData, nil),
//               let imageProperties = CGImageSourceCopyPropertiesAtIndex(imageSource, 0, nil) as? [String: Any],
//               let gpsInfo = imageProperties[kCGImagePropertyGPSDictionary as String] as? [String: Any],
//               let lat = gpsInfo[kCGImagePropertyGPSLatitude as String] as? Double,
//               let long = gpsInfo[kCGImagePropertyGPSLongitude as String] as? Double {
//
//                            latitude = lat
//                            longitude = long
//
//                           let coordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
//
//                           // Now you have the latitude and longitude in the `coordinates` variable
//                           // You can use this information as needed
//                           print("Latitude: \(latitude), Longitude: \(longitude)")
//
//
//
//                       }
            
            
        
        }
        
        func addition(elementOnSave: Images, elementOnAppear: Unrapped_Info) {
            imagesInfo.append(elementOnSave)                  // added in array for saving in documents directory
            presentationOfImage.append(elementOnAppear)       // added in array for presentation
            save()
        }
        
        func save() {
            do {
                let data = try JSONEncoder().encode(imagesInfo)
                try data.write(to: savePath, options: [.atomicWrite, .completeFileProtection])
            } catch {
                print ("could not save data")
            }
            
        }
        
        
        func update(current_element: Unrapped_Info,elementOnSave: Images, elementOnAppear: Unrapped_Info) {
            

           
            if let index = presentationOfImage.firstIndex(of: current_element){
                presentationOfImage[index] = elementOnAppear
            }

            if let index = imagesInfo.firstIndex(where: {$0.filename == current_element.filename}) {
                imagesInfo[index].filename = elementOnSave.filename
            }
            

            save()
        }
        
        
        func delete(uuid:UUID) {
            if let index = imagesInfo.firstIndex(where: {$0.id == uuid}) {
                imagesInfo.remove(at: index)
            }
            if let index = presentationOfImage.firstIndex(where: {$0.id == uuid }) {
                presentationOfImage.remove(at: index)
            }
            
        }
        
        

        
        
        func formingUIImageArray () {
            for index in 0..<imagesInfo.count {
                if let uiimage = UIImage(data: imagesInfo[index].imagedata) {
                    let new_image = Image(uiImage: uiimage)
                    presentationOfImage.append(Unrapped_Info(id: imagesInfo[index].id, filename: imagesInfo[index].filename, image: new_image, imagedata: imagesInfo[index].imagedata, latitude: imagesInfo[index].latitude, longitude: imagesInfo[index].longitude))
                }
            }
            
        }
        
        
        
        
        
    }
    
}
