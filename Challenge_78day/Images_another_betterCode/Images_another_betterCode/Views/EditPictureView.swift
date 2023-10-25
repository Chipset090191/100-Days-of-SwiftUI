//
//  EditPictureView.swift
//  Images_another_betterCode
//
//  Created by Михаил Тихомиров on 20.08.2023.
//

import SwiftUI
import CoreLocation
import MapKit

struct EditPictureView: View {
    
    @Environment (\.presentationMode) var presentationMode
    
    @Binding var pictures: [Picture]
    @State private var image:Image?
    @State private var inputImage:UIImage?
    @State private var imageName = ""
    @State private var showingImagePicker = false
    @State private var showingSourseTypeAlert = false
    @State private var centerCoordinate = CLLocationCoordinate2D()
    @State private var locations = [CodableMKPointAnnotation]()         // we get that from PlusButton
    @State private var selectedPlace:MKPointAnnotation?
    @State private var locationFetcher = LocationFetcher()
    @State private var pictureSourceType = UIImagePickerController.SourceType.photoLibrary
    
    
    
    var body: some View {
        NavigationView {
            VStack{
                HStack{
                    TextField("Name Field", text: $imageName)
                        .frame(width: 300, height:50, alignment: .center)
                        .background(Color.gray)
                        .clipShape(Capsule())
                        .overlay(Capsule().stroke(.orange, lineWidth: 3))
                        .multilineTextAlignment(.center)
                }
                if image != nil {
                    image?
                        .resizable()
                        .scaledToFit()
                } else {
                    Button {
                        self.showingSourseTypeAlert = true
                    }label: {
                        Text ("Select image")
                    }
                    .frame(width: 250, height: 70, alignment: .center)
                    .background(Color.yellow)
                    .cornerRadius(20)
                    .padding(.top,100)
                }
                
                ZStack {
                    MapView(centerCoordinate: $centerCoordinate, annotations: locations)
                        .edgesIgnoringSafeArea(.all)
                    
                    CircleView()
                    VStack{
                        Spacer()
                        HStack {
                            Spacer()
                            PlusButtonView(locations: $locations, centerCoordinate: $centerCoordinate, imageName: self.imageName)
                        }
                    }
                    
                }
            }
            .padding(.top, 10)
            .sheet(isPresented: $showingImagePicker, onDismiss: {
                addNewImage()       // after Picker worked we start our addNewImage func
            }) {
                ImagePicker(image: self.$inputImage, pickerSourceType: self.$pictureSourceType)
            }
            .onAppear{
                self.locationFetcher.start()
            }
            .alert(isPresented: $showingSourseTypeAlert) {
                if imageName.isEmpty {
                   return Alert(title: Text("Image name is Empty"), message: Text("Please enter Image"), dismissButton: .default(Text("OK")))
                } else {
                    return Alert(title: Text("Take photo from: "), message: nil, primaryButton: .default(Text("Photo Library"), action: {
                        self.pictureSourceType = .photoLibrary
                        self.showingImagePicker = true
                    }), secondaryButton: .default(Text("Camera"), action: {
                        self.pictureSourceType = .camera
                        self.showingImagePicker = true
                    }))
                }
            }
            .toolbar {
                Button {
                    self.savePictures()
                } label: {
                    Text("Save")
                }

            }
        }
    }
    
    func addNewImage() {
        guard let inputImage = inputImage else { return }
        
        image = Image(uiImage: inputImage)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if pictureSourceType == .camera {
            if let location = self.locationFetcher.lastKnownLocation{
                let newLocation = CodableMKPointAnnotation()
                newLocation.coordinate = location
                newLocation.title = "Location for Photo with name: \(self.imageName)"
                newLocation.subtitle = "Locations added: \(formatter.string(from: Date()))"
                self.locations.append(newLocation)
            }
        }
    }
    
    func savePictures() {
        let picture = Picture(id: UUID(), pictureName: self.imageName, locations: self.locations)
        self.pictures.append(picture)
        MenageData.savesImage(pathName: picture.id.uuidString, inputImage: self.inputImage)   // save picture itself
        MenageData.savedPictures(pathName: "Pictures", pictures: self.pictures)                 // save the common info about picture
        
        
        self.presentationMode.wrappedValue.dismiss()
        
    }
    
    
}



//struct EditPictureView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditPictureView()
//    }
//}
