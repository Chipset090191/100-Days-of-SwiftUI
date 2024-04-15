//
//  AddPhoto_ViewModel.swift
//  ImagesFromLibrary
//
//  Created by Михаил Тихомиров on 07.04.2024.
//

import Foundation
import SwiftUI
import MapKit

@MainActor class AddPhotoViewModel: ObservableObject {
    
  
    @Published var imageName = ""
    
    @Published var image:Image?
    
    @Published var inputImage:UIImage?
    
    @Published var showingSourseAlert = false
    
    @Published var showingImagePicker = false
    
    @Published var centerCoordinate = CLLocationCoordinate2D()
    
    @Published var locations = [MKPointAnnotationCodable]()
    
    @Published var locationFetcher = LocationFetcher()
    
    
    
    @Binding var pictures: [PictureInfo]
    
    @Published var pictureSourceType = UIImagePickerController.SourceType.photoLibrary
    

    init(pictures: Binding<[PictureInfo]>) {
        _pictures = pictures
    }
    
    func addNewImage() {
        guard let inputImage = inputImage else { return }
        
        image = Image(uiImage: inputImage)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if pictureSourceType == .camera {
            if let location = self.locationFetcher.lastKnownLocation{
                let newLocation = MKPointAnnotationCodable()
                newLocation.coordinate = location
                newLocation.title = "Photo: \(self.imageName)"
                newLocation.subtitle = "Locations added: \(formatter.string(from: Date()))"  // current date()
                self.locations.append(newLocation)
            }
        }
    }
    
    func save() {
        // prepare our Data of Image and save it
        if let jpegData = inputImage?.jpegData(compressionQuality: 0.8) {
            let newElement = PictureInfo(id: UUID(), PicName: self.imageName, locations: self.locations, PicData: jpegData)
            pictures.append(newElement)
//            
            DataManaging.savePictureInfo(pathName: DataManaging.AccessKey.keyForPictures.rawValue, pictures: pictures)
        } else {
            print ("we`ve got problem with saving data")
            return
        }
    }

    func AlertType() -> Alert {
        if self.imageName.isEmpty {
           return Alert(title: Text("Image name is Empty"), message: Text("Please enter the Image name!"), dismissButton: .default(Text("OK")))
        } else {
            return Alert(title: Text("Take photo from: "), message: nil, 
                   primaryButton:
                            .default(Text("Photo Library"), action: {
                                                              self.pictureSourceType = .photoLibrary
                                                              self.showingImagePicker = true
                                                                    }),
                   secondaryButton:
                            .default(Text("Camera"), action: {
                                                            self.pictureSourceType = .camera
                                                            self.showingImagePicker = true
                                                             }))
        }
    }
    
    
    
    
    
    
    
    

    
    
    

    
}
