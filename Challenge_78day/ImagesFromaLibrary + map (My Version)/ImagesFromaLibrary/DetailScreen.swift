//
//  DetailScreen.swift
//  ImagesFromaLibrary
//
//  Created by Михаил Тихомиров on 14.08.2023.
//

import SwiftUI
import MapKit

struct DetailScreen: View {
    
//    @State private var mapRegion : MKCoordinateRegion
    @StateObject private var detailscreenModel = DetailScreenModel()
    
    
    @State private var map:MKCoordinateRegion
    
    
    @State private var localname:String
    @State private var forDelete = false
    
    @Binding var del: UUID
    
    
    
    @Environment (\.dismiss) var dismiss
    
    var image: Image
    var imagedata: Data
    var name: String
    var key: String
    var uuid: UUID
    
    var coordinateRegion:MKCoordinateRegion
    
//    var currentLocation:CLLocationCoordinate2D
    
//    var mapRegion: MKCoordinateRegion {
//        MKCoordinateRegion(center: currentLocation, span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25))
//    }
//
    

    var onSaveAndAppear:(Images, Unrapped_Info) -> Void
    
    
    var body: some View {
        NavigationView{
            ZStack{
                LinearGradient(gradient: Gradient(stops: [Gradient.Stop(color: .white, location: 0.15),Gradient.Stop(color: .blue, location: 0.99)]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                VStack(spacing: 10) {
                    VStack{
                        Section {
                            TextField("name of file", text: $localname)
                                .italic()
                        }
                        
                        ZStack{
                            image
                                .resizable()
                                .scaledToFit()
                            
                            
                        }
                        
                        
                        
                        .overlay(
                            Rectangle()
                                .stroke(lineWidth: 3)
                        )
                    }
//                    .padding([.horizontal, .vertical])
                    
//                    Spacer()
//                    Spacer()
                    
                    ZStack {
                        Map(coordinateRegion: $map, annotationItems: detailscreenModel.MapAnnotationArray) { location in
                            
                            MapAnnotation(coordinate: location.coordinate) {
                                VStack {
                                    image
                                        .resizable()
                                        .scaledToFit()
                                        .foregroundColor(.red)
                                        .frame(width: 44, height: 44)  // 44 - that`s a magic number. Reccomended minimum number for size  for Apple
                                        .background(.black)
                                        .clipShape(Circle())
                                    
                                    
                                    Text (location.filename)
                                        .fixedSize()  // we are sure our text won`t be shortened no matter how big it is
                                }
                            }
                        }
                        .clipShape(Capsule())
                        .shadow(radius: 15)
                        .overlay {
                            Capsule()
                                .stroke(.blue, lineWidth: 3).blur(radius: 2)
                            
                        }
                        
                        // that`s our central point on the map
                        Circle()
                            .fill(.blue)
                            .opacity(0.3)
                            .frame(width: 32, height: 32)
                        //                    }
                        
                        VStack{
                            Spacer()
                            Spacer()
                            HStack{
                                Spacer()

                                Button {
                                    //
                                    let element = Images(id: uuid, filename: localname, imagedata: imagedata, latitude: map.center.latitude, longitude: map.center.longitude)
                                    
                                    detailscreenModel.MapAnnotationArray.append(element)
                                    
                                }label: {
                                    Image(systemName: "plus")
                                        .padding()
                                        .background(.black.opacity(0.75))
                                        .foregroundColor(.white)
                                        .font(.title)
                                        .clipShape(Circle())
                                        .padding()
                                }
                                
                                
                            }
                            
                            
                            
                        }

                    }
                    .padding([.horizontal, .vertical])
                    .ignoresSafeArea()
                   
                    
                
                }
//                .padding([.horizontal, .vertical])
                
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Delete") {
                            forDelete = true
                        }
                        .disabled(key == "c" ? true: false)
                        
                    }
                    
                    
                    ToolbarItem(placement: .navigationBarTrailing){
                        Button(key == "c" ? "Save" : "Update"){
                            if key == "c" {
                                let new_elementOnSave = Images(id: uuid, filename: localname, imagedata: imagedata, latitude: map.center.latitude, longitude: map.center.longitude)
                                

                                let new_element_OnAppear = Unrapped_Info(id: uuid, filename: localname, image: image, imagedata: imagedata, latitude: map.center.latitude, longitude: map.center.longitude)
                                
                                onSaveAndAppear(new_elementOnSave, new_element_OnAppear)
                                
                            } else if key == "e" {
                                let commonUUID = UUID()
                                
                                let new_elementOnSave = Images(id: commonUUID, filename: localname, imagedata: imagedata, latitude: map.center.latitude, longitude: map.center.longitude)
                                
       
                                
                                let new_element_OnAppear = Unrapped_Info(id: commonUUID, filename: localname, image: image, imagedata: imagedata, latitude: map.center.latitude, longitude: map.center.longitude)
                                
                                onSaveAndAppear(new_elementOnSave, new_element_OnAppear)
                            }
                            dismiss()
                        }
                        .disabled(localname == "" && detailscreenModel.MapAnnotationArray.isEmpty ? true : false)
                    }
                }
                .navigationTitle("Detail Info")
                .navigationBarTitleDisplayMode(.inline)
                .alert("Request for deleting", isPresented: $forDelete) {
                    Button(role: .destructive) {
                        del = uuid
                        dismiss()
                    } label: {
                        Text ("Yes")
                    }
                    
                    
                } message: {
                    Text("Do you really want to delete this photo?")
                }
                
                
            }
            .preferredColorScheme(.light)
            .onAppear{
                if key == "e" {
                    let element = Images(id: uuid, filename: localname, imagedata: imagedata, latitude: coordinateRegion.center.latitude, longitude: coordinateRegion.center.longitude)
                    detailscreenModel.MapAnnotationArray.append(element)
                }
            }
        }
        
        
        
        
    }
    
    
    init(del: Binding<UUID>, image: Image, imagedata: Data, name: String, key:String, uuid:UUID, coordinateRegion:MKCoordinateRegion, onSaveAndAppear: @escaping (Images, Unrapped_Info) -> Void) {
        self.image = image
        self.imagedata = imagedata
        self.name = name
        self.key = key
        self.uuid = uuid
        self.coordinateRegion = coordinateRegion
        
        self.onSaveAndAppear = onSaveAndAppear
        
        _localname = State(initialValue: name)
        _del = del
        _map = State(initialValue: coordinateRegion)
        
    }
    

}



struct DetailScreen_Previews: PreviewProvider {
    
    static let binding = Binding<UUID> (
        get: { UUID() },
        set: { _ in }
    
    )
    
    static let location = CLLocationCoordinate2D(latitude: 50, longitude: 0)
    
    static var previews: some View {
        DetailScreen(del: binding, image: Image("Test"),imagedata: Data(), name: "Test_name", key: "e", uuid: UUID(), coordinateRegion: MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 50, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25))) { _,_ in }
    }
}
