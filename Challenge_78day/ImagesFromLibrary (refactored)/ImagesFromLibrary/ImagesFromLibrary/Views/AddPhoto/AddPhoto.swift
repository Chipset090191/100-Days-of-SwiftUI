//
//  AddPhoto.swift
//  ImagesFromLibrary
//
//  Created by Михаил Тихомиров on 07.04.2024.
//

import SwiftUI
import _MapKit_SwiftUI

struct AddPhoto: View {
    
    @Environment (\.dismiss) var dismiss
    
    @StateObject private var viewModel: AddPhotoViewModel
    

    
    
    
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                Spacer()
                Spacer()
                
                HStack {
                    TextField("name of photo", text: $viewModel.imageName)
                        .italic()
                        .padding(.vertical, 10)
                        .frame(width: 300, height:30, alignment: .center)
                        .clipShape(RoundedRectangle(cornerRadius: 2))
                        .overlay(RoundedRectangle(cornerRadius: 2).stroke(.black, lineWidth: 2))
                        .multilineTextAlignment(.center)
                }
                
                if viewModel.image != nil {
                    viewModel.image?
                        .resizable()
                        .scaledToFit()
                        .overlay(
                            Rectangle()
                                .stroke(lineWidth: 2)
                        )
                        .padding(.horizontal, 3)
                } else {
                    Button {
                        viewModel.showingSourseAlert = true
                    }label: {
                        Text ("Select image")
                    }
                    .frame(width: 120, height: 50, alignment: .center)
                    .background(Color.green)
                    .foregroundStyle(Color.black)
                    .cornerRadius(20)
                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(.black, lineWidth:3))
                    .padding(.top,100)
                }
                
                ZStack {
                    MapView(centerCoordinate: $viewModel.centerCoordinate, annotations: viewModel.locations)
                        .clipShape(Capsule())
                        .shadow(radius: 10)
                        .overlay {
                            Capsule()
                                .stroke(.blue, lineWidth: 3).blur(radius: 1)
                        }
                        
                    
                    // that`s our central point on the map
                    Circle()
                        .fill(.blue)
                        .opacity(0.3)
                        .frame(width: 32, height: 32)
                    
                    VStack{
                        Spacer()
                        Spacer()
                        HStack{
                            Spacer()
                            
                            PlusButtonView(locations: $viewModel.locations, centerCoordinate: $viewModel.centerCoordinate, imageName: viewModel.imageName)
                        }
                    }
                }
                .padding([.horizontal, .vertical])
                .ignoresSafeArea()
            }
            .onAppear {
                // fetching location and asking user to get data
                viewModel.locationFetcher.start()
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button{
                        viewModel.save()
                        dismiss()
                    } label: {
                        Text("Save")
                    }
                    .disabled(viewModel.inputImage == nil ? true : false)
                }
            }
            .sheet(isPresented: $viewModel.showingImagePicker, onDismiss: {
                viewModel.addNewImage()
            }) {
                ImagePicker(image: $viewModel.inputImage, pickerSourceType: $viewModel.pictureSourceType)
            }
            .alert(isPresented: $viewModel.showingSourseAlert) {
                viewModel.AlertType()
            }
        }
    }
    
    
    init(pictures: Binding<[PictureInfo]>) {
        _viewModel = StateObject(wrappedValue: AddPhotoViewModel(pictures: pictures))
    }
    
}

extension MKPointAnnotationCodable {
    static var exampleForAddPhoto:MKPointAnnotationCodable {
        let newAnnotation = MKPointAnnotationCodable()
        newAnnotation.coordinate = CLLocationCoordinate2D(latitude: 50, longitude: 0)
        newAnnotation.title = "Test"
        newAnnotation.subtitle = "Sub Info"
        return newAnnotation
    }
}


struct AddPhoto_Previews: PreviewProvider {
    @State static var previewImages: [PictureInfo] = [PictureInfo(id: UUID(), PicName: "Test", locations: [MKPointAnnotationCodable.exampleForAddPhoto], PicData: Data())]
    
    static var previews: some View {
        AddPhoto(pictures: $previewImages)
    }
}
